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

class CoreDataWorkerSpec: XCTestCase {
    
    var sut: CoreDataWorker!
    
    override func setUp() {
        sut = CoreDataWorker()
    }
    
    func testSaveAnInstanceOfMovieMOShouldNotThrowsAnException() {
        expect { try self.sut.save() }.toNot( throwError() )
    }

    
}
