//
//  CoreDataManagerSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 04/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Nimble
@testable import TheMovsApp

class CoreDataManagerSpec: XCTestCase {
    
    func testPersistentContainerShouldNotBeNil() {
        expect(CoreDataManager.shared.persistentContainer).toNot(beNil())
    }
    
    func testSaveContextFunctionShouldNotThrowError() {
        expect { try CoreDataManager.shared.saveContext() }.toNot( throwError() )
    }
    
}
