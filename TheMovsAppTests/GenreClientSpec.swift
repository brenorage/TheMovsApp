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

final class GenreClientSpec: XCTestCase {
    
    private var sut: GenreClient!
    private var workerStub: CoreDataWorkerStub!
    private var serviceStub: ServiceStub!
    
    override func setUp() {
        serviceStub = ServiceStub()
        workerStub = CoreDataWorkerStub()
        sut = GenreClient(httpService: serviceStub, coreDataWorker: workerStub)
    }
    
    func testGenreClientShouldSaveGenresAfterRequest() {
        sut.getGenres(completion: { result in
            if case let .success(isSaved) = result {
                XCTAssertTrue(isSaved)
            } else {
                XCTFail()
            }
        })
    }

}

private final class ServiceStub: HTTPServicesProtocol {
    
    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (ResultType<T>) -> ()) {
        
        let bundle = Bundle(for: GenreClientSpec.self)
        let url = bundle.url(forResource: "Genres", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode(GenreResponseModel.self, from: jsonData)
        
        let genreResponse = response as! T
        completion(.success(genreResponse))
    }
    
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    
    init() {
        
    }
    
    init(persistentContainer: NSPersistentContainer) {
        
    }
    
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        
    }
    
    func save() throws {
        
    }
    
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) {
        
    }

    
}
