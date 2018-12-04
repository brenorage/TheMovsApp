//
//  MoviesClientTest.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
@testable import TheMovsApp

class MoviesClientTest: XCTestCase {
    
    var httpServices: HTTPServiceMock!
    var moviesClient: MoviesListClient!
    
    override func setUp() {
        httpServices = HTTPServiceMock()
        moviesClient = MoviesListClient(httpService: httpServices)
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
            case .success(_):
                XCTAssert(self.moviesClient.nextPage == 2)
            case .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}


class HTTPServiceMock: HTTPServicesProtocol {
    
    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (RequestResultType<T>) -> ()) {
        let data = try! Data.init(contentsOf: injectedURL, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(T.self, from: data)
        completion(.success(object))
    }
}
