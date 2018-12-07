//
//  MoviesGridViewSpec.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 05/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Nimble_Snapshots

@testable import TheMovsApp

class MoviesGridViewSpec: QuickSpec {

    override func spec() {
        describe("a 'MoviesGridViewController'") {
            
            var presenter: MockMoviesListPresenter!
            var moviesGridViewSUT: MoviesGridViewController!
            
            beforeEach {
                presenter = MockMoviesListPresenter()
                moviesGridViewSUT = MoviesGridViewController(presenter: presenter)
                moviesGridViewSUT.view.frame = UIScreen.main.bounds
                _ = moviesGridViewSUT.view
            }
            
            it("should have the expected look like MoviesGridListView with mock") {
//                expect(moviesGridViewSUT).toEventually(recordSnapshot(named: "MoviesGridViewController"))
                expect(moviesGridViewSUT).toEventually(haveValidSnapshot(named: "MoviesGridViewController"))
            }
            
            it("should have the expected look of a loading screen") {
                moviesGridViewSUT.hideMoviesGrid()
                moviesGridViewSUT.showLoading()
                
//                expect(moviesGridViewSUT).toEventually(recordSnapshot(named: "MoviesGridViewControllerLoadingState"))
                expect(moviesGridViewSUT).toEventually(haveValidSnapshot(named: "MoviesGridViewControllerLoadingState"))
            }
            
            it("should have two sections in collection view") {
                presenter.getMoreMovies()
//                                expect(moviesGridViewSUT).toEventually(recordSnapshot(named: "MoviesGridViewControllerWithTwoPages"))
                expect(moviesGridViewSUT).toEventually(haveValidSnapshot(named: "MoviesGridViewControllerWithTwoPages"))

            }
            
            it("should show error view in movies grid") {
                presenter.getListWithError()
//                                                expect(moviesGridViewSUT).toEventually(recordSnapshot(named: "MoviesGridViewControllerWithError"))
                expect(moviesGridViewSUT).toEventually(haveValidSnapshot(named: "MoviesGridViewControllerWithError"))
                
            }
        }
    }
}

class MockMoviesListPresenter: MoviesListPresenterProtocol {
    
    weak var viewProtocol: MoviesGridViewProtocol?
    
    var moviesPages: [[MovieModel]] = []
    
    func getList() {
        let filePath = Bundle(for: MoviesGridViewSpec.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: data)
        moviesPages.append(object.results)
        viewProtocol?.showMoviesGrid()
    }
    
    func getListWithError() {
        viewProtocol?.hideMoviesGrid()
        viewProtocol?.showError()
    }
    
    func getMoreMovies() {
        let filePath = Bundle(for: MoviesGridViewSpec.self).path(forResource: "MoviesListPage2", ofType: ".json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: data)
        moviesPages.append(object.results)
        viewProtocol?.reloadMoviesGrid()
    }
}
