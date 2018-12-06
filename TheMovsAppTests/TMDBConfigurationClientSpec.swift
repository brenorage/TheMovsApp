//
//  TMDBConfigurationClientSpec.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest

@testable import TheMovsApp

class TMDBConfigurationClientSpec: XCTestCase {

    var tmdbConfigClient: TMDBConfigurationClient!
    
    override func setUp() {
        let httpService: HTTPServicesProtocol = MockHTTPServiceForTMDBConfig()
        tmdbConfigClient = TMDBConfigurationClient(httpService: httpService)
    }

    override func tearDown() {
        tmdbConfigClient = nil
    }

    func testIfClientSaveATMDBMO() {
        let expectation = XCTestExpectation(description: "Test if TMDBConfigurationClient saves correctly the object")
        tmdbConfigClient.getConfigurationModel { result in
            switch result {
            case let .success(saveIsSuccessful):
                XCTAssert(saveIsSuccessful)
            case .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

}

class MockHTTPServiceForTMDBConfig: HTTPServicesProtocol {

    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (ResultType<T>) -> ()) {
        let tmdbObject = TMDBConfigurationModel.init(baseURL: "baseURL", backdropSizes: ["backdropSize"], posterSizes: ["posterSize"]) as! T
        completion(.success(tmdbObject))
    }
}
