//
//  NetworkLayerTest.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 30/11/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Mockingjay

@testable import TheMovsApp

struct Person: Decodable {
    let name: String
    let age: String
}

class NetworkLayerTest: XCTestCase {
    
    let personJson = [
        "name" : "Breno",
        "age": "23"
    ]
    
    let personJson2 = [
        "name" : "Rage",
        "age" : "21"
    ]
    
    var networkService: HTTPServicesProtocol!
    
    override func setUp() {
        super.setUp()
        networkService = HTTPServices()
    }

    override func tearDown() {
        networkService.cancelTasks()
        removeAllStubs()
    }

    func testIfNetworkLayerCanFormatJSONWithAGoodFormat() {
        let mockURL = "https://www.google.com"
        let url = URL(string: mockURL)!
        let expectation = XCTestExpectation(description: "Test JSON parse in network layer")
        self.stub(everything, json(personJson))
        networkService.get(url: url) { (result: RequestResultType<Person>) in
            switch result {
            case let .success(person):
                XCTAssertTrue(person.name == "Breno")
                XCTAssertTrue(person.age == "23")
            default:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testIfNetworkLayerCanFormatJSONArrayWithAGoodFormat() {
        let mockURL = "https://www.google.com"
        let url = URL(string: mockURL)!
        let expectation = XCTestExpectation(description: "Test JSON parse in network layer")
        self.stub(everything, json([personJson, personJson2]))
        networkService.get(url: url) { (result: RequestResultType<[Person]>) in
            switch result {
            case let .success(persons):
                XCTAssert(persons.count == 2)
            default:
                XCTFail()
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testIfNetworkLayerCanHandleAError() {
        let mockURL = "https://www.google.com"
        let url = URL(string: mockURL)!
        let expectation = XCTestExpectation(description: "Test Error in network layer")
        self.stub(everything, failure(NSError.init(domain: "Stub Error", code: 500, userInfo: nil)))
        networkService.get(url: url) { (result: RequestResultType<Person>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure:
                XCTAssert(true)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
