//
//  TMDBConfigurationClientSpec.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData

@testable import TheMovsApp

class TMDBConfigurationClientSpec: XCTestCase {

    var tmdbConfigClient: TMDBConfigurationClient!
    
    override func setUp() {
        let httpService: HTTPServicesProtocol = MockHTTPServiceForTMDBConfig()
        tmdbConfigClient = TMDBConfigurationClient(httpService: httpService, userDefault: UserDefaultMockForTMDBConfig())
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
        let tmdbObject = TMDBConfigurationModel(baseURL: "baseURL", backdropSizes: ["backdropSize"], posterSizes: ["posterSize"])
        let tmdbConfig = TMDBConfigurationModelResponse.init(images: tmdbObject) as! T
        completion(.success(tmdbConfig))
    }
}

class UserDefaultMockForTMDBConfig: UserDefaultWrapperProtocol {
    func saveJSON<T>(object: T, with key: String) where T : Encodable {
        
    }
    
    func getObjectFromJSON<T>(with key: String) -> T? where T : Decodable {
        return nil
    }
    
    func get<T>(with key: String) -> T? {
        return nil
    }
    
    func save<T>(object: T, with key: String) { }
    
    func deleteItem<T: Equatable>(in index: Int, with key: String) -> [T]? {
        return []
    }
}
