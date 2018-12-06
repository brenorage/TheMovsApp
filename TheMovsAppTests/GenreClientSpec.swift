//
//  GenreClientSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 06/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
@testable import TheMovsApp

class GenreClientSpec: XCTestCase {
    
    var sut: GenreClient!
    
    override func setUp() {
        let serviceStub = ServiceStub()
        let workerStub = GenreDataWorkerStub()
        sut = GenreClient(httpService: serviceStub, coreDataWorker: workerStub)
    }
    
    func testGenreClientShouldSaveGenresAfter() {
        sut.getGenres(completion: { result in
            if case let .success(isSaved) = result {
                XCTAssertTrue(isSaved)
            } else {
                XCTFail()
            }
        })
    }

}

private class ServiceStub: HTTPServicesProtocol {
    
    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (ResultType<T>) -> ()) {
        
        let bundle = Bundle.main
        let url = bundle.url(forResource: "Genres", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode(GenreResponseModel.self, from: jsonData)
        
        let genreResponse = response as! T
        completion(.success(genreResponse))
    }
    
}

private class GenreDataWorkerStub: CoreDataWorkerProtocol {
    
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject { }
    
    func save() throws { }
    
    func delete(enity: NSManagedObject) { }
    
}
