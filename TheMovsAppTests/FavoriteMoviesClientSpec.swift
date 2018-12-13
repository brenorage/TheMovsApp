//
//  FavoriteMoviesClientSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 13/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
@testable import TheMovsApp

final class FavoriteMoviesClientSpec: XCTestCase {
    
    private var sut: FavoriteMoviesClient!
    private var coreDataStub: CoreDataWorkerStub!
    
    override func setUp() {
        coreDataStub = CoreDataWorkerStub()
        sut = FavoriteMoviesClient(coreDataWorker: coreDataStub)
    }
    
    func testGetFavoriteMovieListShouldConvertManagedObjectsInValidMovieModels() {
        sut.getFavoriteMovieList() { result in
            if case let .success(list) = result {
                let movieModel = list.first!
                XCTAssertEqual("Thor Ragnarok", movieModel.title)
                XCTAssertEqual(12345, movieModel.movieId)
                XCTAssertEqual("2018", movieModel.releaseYear)
                XCTAssertEqual("abcdefgh", movieModel.overview)
                XCTAssertEqual("/xxx", movieModel.posterPath)
                XCTAssertEqual("/yyy", movieModel.backdropPath)
            } else {
                XCTFail()
            }
        }
    }
    
    func testRemoveFavoriteMovieShouldDeleteFromDatabase() {
        let expectation = XCTestExpectation(description: "Test if movie model will be found and deleted from database")
        let movieModel = MovieModel(movieId: 12345, title: "Thor Ragnarok", overview: "abcdefgh", releaseDate: "2018-11-14", posterPath: "/xxx", backdropPath: "/yyy")
        sut.removeFromFavorites(movieModel, completion: { result in
            if case let .success(isDeleted) = result {
                XCTAssertTrue(isDeleted)
            } else {
                XCTFail()
            }
            
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 40.0)
    }
    
    
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    
    init() { }
    init(context: NSManagedObjectContext) { }
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        let movieMO = creatMovieMO()
        completion(.success([movieMO] as! [T]))
    }
    func fetch<T>(with predicate: NSPredicate, completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        let movieMO = creatMovieMO()
        completion(.success([movieMO] as! [T]))
    }
    func save() throws { }
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) {
        completion(.success(true))
    }
    
    func creatMovieMO() -> MovieMO {
        let movieMO = MovieMO()
        movieMO.title = "Thor Ragnarok"
        movieMO.movieId = 12345
        movieMO.posterPath = "/xxx"
        movieMO.backdropPath = "/yyy"
        movieMO.year = "2018-11-14"
        movieMO.overview = "abcdefgh"
        return movieMO
    }
    
}
