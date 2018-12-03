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
    
    func testIfGetReleaseYearLogicIsCorrect() {
        let movieJSON = """
        {
            "title" : "Filme",
            "overview" : "Esse é um filme de teste para testar a logica",
            "release_date" : "2018-10-11",
            "poster_path" : "Essa é uma poster path",
            "genre_ids" : [1,2,3,4]
        }
    """.data(using: .utf8)!
        
        let movie = try! JSONDecoder().decode(MovieModel.self, from: movieJSON)
        let year = movie.releaseYear
        XCTAssert(year == "2018")
    }

}
