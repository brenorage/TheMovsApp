//
//  CoreDataWorkerSpecs.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 05/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Nimble
@testable import TheMovsApp

final class CoreDataWorkerSpec: XCTestCase {
    
    var sut: CoreDataWorkerStub!
    
    override func setUp() {
        sut = CoreDataWorkerStub()
    }
    
    func testSaveDatabaseShouldNotThrowsAnException() {
        expect { try self.sut.save() }.toNot( throwError() )
    }

    
}
