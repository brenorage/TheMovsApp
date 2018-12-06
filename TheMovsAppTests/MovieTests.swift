//
//  MovieTests.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData

@testable import TheMovsApp

class MovieTests: XCTestCase {
    
    let movieJSON = """
        {
            "title" : "Filme",
            "overview" : "Esse é um filme de teste para testar a logica",
            "release_date" : "2018-10-11",
            "poster_path" : "/posterPath",
            "genre_ids" : [1,2,3,4]
        }
    """.data(using: .utf8)!
    
    func testIfGetReleaseYearLogicIsCorrect() {
        let movie = try! JSONDecoder().decode(MovieModel.self, from: movieJSON)
        let year = movie.releaseYear
        XCTAssert(year == "2018")
    }
    
    func testIfModelMountCorrectlyPosterURL() {
        let movie = try! JSONDecoder().decode(MovieModel.self, from: movieJSON)
        movie.coreDataWorker = CoreDataWorkerMockForMovieModel()
        let expectation = XCTestExpectation(description: "test if model form a correctly url")
        movie.getPosterURL { url in
            XCTAssert(url!.absoluteString == "http://baseurl.com/original/posterPath")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}

class CoreDataWorkerMockForMovieModel: CoreDataWorkerProtocol {
    func delete(enity: NSManagedObject) {
        
    }
    
    func fetchAll<T: NSManagedObject>(completion: @escaping (ResultType<Array<T>>) -> ()) {
        let configModelMO = TMDBConfigurationMO()
        configModelMO.baseURL = "http://baseurl.com/"
        configModelMO.backdropSizes = ["size1"]
        configModelMO.posterSizes = ["size2"]
        completion(.success([configModelMO as! T]))
    }
    
    func save() throws {
        
    }
}
