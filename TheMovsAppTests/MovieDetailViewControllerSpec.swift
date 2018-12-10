//
//  MovieDetailViewControllerSpec.swift
//  TheMovsAppTests
//
//  Created by André Souza on 09/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
import Quick
import Nimble
import Nimble_Snapshots
@testable import TheMovsApp

final class MovieDetailViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("a 'MovieDetailViewController'") {
            
            var presenter: MovieDetailPresenter!
            var sut: MovieDetailViewController!
            var coreDataWorkerStub: CoreDataWorkerStub!
            var genreClienStub: GenreClientStub!
            var movieStub: MovieModel!
            
            beforeEach {
                movieStub = self.getMovie()
                coreDataWorkerStub = CoreDataWorkerStub()
                genreClienStub = GenreClientStub(httpService: HTTPServices(), coreDataWorker: coreDataWorkerStub)
                
                presenter = MovieDetailPresenter(with: movieStub,
                                                     coreDataWorker: coreDataWorkerStub,
                                                     genreClient: genreClienStub)
                
                sut = MovieDetailViewController(presenter: presenter)
            }
            
            it("should have the expected look and feel with movie mock") {
//                expect(sut).toEventually(recordSnapshot(named: "MovieDetailViewController"))
                expect(sut).toEventually(haveValidSnapshot(named: "MovieDetailViewController"))
            }
            
            
        }
    }
    
    private func getMovie() -> MovieModel {
        let bundle = Bundle(for: MovieDetailPresenterSpec.self)
        let url = bundle.url(forResource: "MovieDetail", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(MovieModel.self, from: jsonData)
    }
    
    
}


private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    
    var shouldReturnEmptyList = true
    
    init() { }
    init(context: NSManagedObjectContext) { }
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        if shouldReturnEmptyList {
            completion(.success([]))
        } else {
            let genre1 = GenreMO()
            genre1.name = "Adventure"
            genre1.genreId = Int32(12)
            let genre2 = GenreMO()
            genre2.name = "Horror"
            genre2.genreId = Int32(27)
            completion(.success([genre1, genre2] as! [T]))
        }
    }
    func save() throws { }
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) { }
}


private final class GenreClientStub: GenreClientProtocol {
    init(httpService: HTTPServicesProtocol, coreDataWorker: CoreDataWorkerProtocol) { }
    func getGenres(completion: @escaping RequestCallback<Bool>) { }
}
