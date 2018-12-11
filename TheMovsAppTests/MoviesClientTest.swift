//
//  MoviesClientTest.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
@testable import TheMovsApp

final class MoviesClientTest: XCTestCase {
    
    private var httpServices: HTTPServiceMock!
    private var moviesClient: MoviesListClient!
    private var coreDataWorkerStub: CoreDataWorkerStub!
    
    override func setUp() {
        httpServices = HTTPServiceMock()
        coreDataWorkerStub = CoreDataWorkerStub()
        moviesClient = MoviesListClient(httpService: httpServices, coreDataWorker: coreDataWorkerStub)
    }

    override func tearDown() {
        httpServices = nil
        moviesClient = nil
    }

    func testIfMoviesClientDoRightControlOfThePagination() {
        let expectation = XCTestExpectation(description: "Test if movies client do the right control of pagination")
        let filePath = Bundle(for: MoviesClientTest.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        httpServices.injectedURL = URL(fileURLWithPath: filePath)
        moviesClient.getMovies { result in
            switch result {
            case let .success(pageIndex):
                XCTAssert(pageIndex == 1)
                XCTAssert(self.moviesClient.nextPage == 2)
            case .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testIfMovieListContainsFavoritedMovieBasedOnMoviesSavedInDatabase() {
        let expectation = XCTestExpectation(description: "Test if contains favorite movies")
        let filePath = Bundle(for: MoviesClientTest.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        httpServices.injectedURL = URL(fileURLWithPath: filePath)
        moviesClient.getMovies { result in
            switch result {
            case .success(_):
                let firstMovie = self.moviesClient.movies.first!.first!
                XCTAssertTrue(firstMovie.isFavorite)
            case .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}


private final class HTTPServiceMock: HTTPServicesProtocol {
    
    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (ResultType<T>) -> ()) {
        let data = try! Data.init(contentsOf: injectedURL, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(T.self, from: data)
        completion(.success(object))
    }
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    init() { }
    init(context: NSManagedObjectContext) { }
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        let movie = MovieMO()
        movie.title = "Venom"
        movie.movieId = Int32(335983)
        completion(.success([movie] as! [T]))
    }
    func fetch<T>(with predicate: NSPredicate, completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject { }
    func save() throws { }
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) { }
}
