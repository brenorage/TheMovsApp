//
//  CoreDataWorkerSpec.swift
//  TheMovsAppTests
//
//  Created by André Souza on 09/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
@testable import TheMovsApp


final class CoreDataWorkerSpec: XCTestCase {
    
    private var sut: CoreDataWorker!
    private var contextStub: ManagedObjectContextStub!
    
    override func setUp() {
        contextStub = ManagedObjectContextStub(concurrencyType: .privateQueueConcurrencyType)
        sut = CoreDataWorker(context: contextStub)
    }
    
    func testFetchAllGenresShouldReturnAnArrayWithTwoGenres() {
        let expectation = XCTestExpectation(description: "Test if the returned array contains 2 genres")
        sut.fetchAll() { (result: ResultType<[GenreMO]>) in
            if case let .success(genres) = result {
               XCTAssertEqual(genres.count, 2)
            } else {
                XCTFail("Fetch error")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testSaveShouldNotCallContextSaveIfThereIsNoChanges() {
        try! sut.save()
        XCTAssertFalse(contextStub.didCallSave)
    }

    
}

private final class ManagedObjectContextStub: NSManagedObjectContext {
    
    var didCallSave = false
    var didCallDelete = false
    
    override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        let genre1 = GenreMO()
        genre1.name = "Adventure"
        genre1.genreId = Int32(12)
        let genre2 = GenreMO()
        genre2.name = "Horror"
        genre2.genreId = Int32(27)
        

        return [genre1, genre2]
    }
    
    override func save() throws {
        didCallSave = true
    }
    
    override func delete(_ object: NSManagedObject) {
        didCallDelete = true
    }
    
}
