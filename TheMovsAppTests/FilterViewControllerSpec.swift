//
//  FilterViewControllerSpec.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 13/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Nimble_Snapshots

@testable import TheMovsApp

class FilterViewControllerSpec: QuickSpec {

    override func spec() {
        describe("a 'FilterViewController with FilterTypeState'") {
            
            var filterViewSUT: FilterViewController!
            
            beforeEach {
                let yearFilterModel = FilterModel(filterType: "Ano", options: ["2008", "2009"])
                let genreFilterModel = FilterModel(filterType: "Genero", options: ["Ação", "Horror"])
                
                filterViewSUT = FilterViewController(with: [yearFilterModel, genreFilterModel], filterState: .filterType, filterDelegate: nil)
                filterViewSUT.view.frame = UIScreen.main.bounds
                _ = filterViewSUT.view
            }
            
            it("should have the expected look like FilterViewController with filterTypeState") {
//                expect(filterViewSUT) == recordSnapshot("FilterViewControllerFilterTypeState")
                expect(filterViewSUT) == snapshot("FilterViewControllerFilterTypeState")
            }
        }
        
        describe("a 'FilterViewController with FilterOptionState'") {
            
            var filterViewSUT: FilterViewController!
            
            beforeEach {
                let yearFilterModel = FilterModel(filterType: "Ano", options: ["2008", "2009"])
                
                filterViewSUT = FilterViewController(with: [yearFilterModel], filterState: .selectParams, filterDelegate: nil)
                filterViewSUT.view.frame = UIScreen.main.bounds
                _ = filterViewSUT.view
            }
            
            it("should have the expected look like FilterViewController with filterTypeState") {
//                                expect(filterViewSUT) == recordSnapshot("FilterViewControllerOptionsState")
                expect(filterViewSUT) == snapshot("FilterViewControllerOptionsState")
            }
        }
    }
}
