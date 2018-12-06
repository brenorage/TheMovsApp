//
//  MovieTests.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest

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
        movie.userDefaultWrapper = UserDefaultMockForMovieModel()
        let url = movie.getPosterURL()
        XCTAssert(url!.absoluteString == "http://baseurl.com/w185/posterPath")
    }

}

class UserDefaultMockForMovieModel: UserDefaultWrapperProtocol {
    func saveJSON<T>(object: T, with key: String) where T : Encodable {
        
    }
    
    func getObjectFromJSON<T>(with key: String) -> T? where T : Decodable {
        let configModel = TMDBConfigurationModel(baseURL: "http://baseurl.com/", backdropSizes: ["size1"], posterSizes: ["size2"])
        return configModel as? T
    }
    
    func get<T>(with key: String) -> T? {
        let configModel = TMDBConfigurationModel(baseURL: "http://baseurl.com/", backdropSizes: ["size1"], posterSizes: ["size2"])
        return configModel as? T
    }
    
    func save<T>(object: T, with key: String) { }
    
    func deleteItem<T: Equatable>(in index: Int, with key: String) -> [T]? {
        return []
    }
}
