//
//  MoviesListPresenterTest.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 05/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest

@testable import TheMovsApp

class MoviesListPresenterTest: XCTestCase {

    var presenter: MoviesListPresenter!
    var viewMock = MockMoviesListView()
    var clientMock = MockMoviesClient()
    
    override func setUp() {
        presenter = MoviesListPresenter(moviesClient: clientMock)
        presenter.viewProtocol = viewMock
    }

    override func tearDown() {
        presenter = nil
    }

    func testIfPresenterCallReloadSectionInCorrectlySection() {
        presenter.getList()
        XCTAssert(viewMock.calledShowMovies)
    }

}

class MockMoviesListView: MoviesGridViewProtocol {
    
    var calledShowMovies = false
    
    func showLoading() {}
    
    func hideLoading() {}
    
    func showMoviesGrid() {
        calledShowMovies = true
    }
    
    func hideMoviesGrid() {}
    
    func reloadMoviesGrid(with sectionIndex: Int) {}
}

class MockMoviesClient: MoviesListClientProtocol {
    var movies: [MoviesPage] = []
    
    required init(httpService: HTTPServicesProtocol = HTTPServices()) { }
    
    func getMovies(completion: @escaping ((RequestResultType<Int>) -> Void)) {
        completion(.success(2))
    }
}
