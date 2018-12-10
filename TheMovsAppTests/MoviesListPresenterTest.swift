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

    func testIfPresenterCallShowMoviesGrid() {
        presenter.getList()
        XCTAssert(viewMock.calledShowMovies)
    }

    func testIfPresenterCallReloadSectionInMovieGrid() {
        presenter.getMoreMovies()
        XCTAssert(viewMock.calledReloadMovies)
    }
}

class MockMoviesListView: MoviesGridViewProtocol {
    
    var calledShowMovies = false
    var calledReloadMovies = false
    
    func showLoading() {}
    
    func hideLoading() {}
    
    func showMoviesGrid() {
        calledShowMovies = true
    }
    
    func hideMoviesGrid() {}
    
    func reloadMoviesGrid() {
        calledReloadMovies = true
    }
    
    func pushDetailViewController(with movie: MovieModel) {
    }
}

class MockMoviesClient: MoviesListClientProtocol {
    var movies: [MoviesPage] = []
    
    required init(httpService: HTTPServicesProtocol = HTTPServices()) { }
    
    func getMovies(completion: @escaping ((ResultType<Int>) -> Void)) {
        completion(.success(2))
    }
}
