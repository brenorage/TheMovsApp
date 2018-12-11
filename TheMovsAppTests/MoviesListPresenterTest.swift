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
    
    func testIfPresenterCallErrorInFirstTimeOfDownloadList() {
        clientMock.result = .failure
        presenter.getList()
        XCTAssert(viewMock.calledShowError)
    }
    
    func testIfPresenterNotCallErrorInGetMoreMovies() {
        clientMock.result = .failure
        presenter.getMoreMovies()
        XCTAssert(!viewMock.calledShowError)
    }
    
    func testIfFavoriteMovieActionWillReloadTheCorretRowIndexPath() {
        presenter.didFavoriteMovie(335983)
        XCTAssertEqual(viewMock.calledIndexPath, IndexPath(item: 0, section: 0))
    }
}

class MockMoviesListView: MoviesGridViewProtocol {
    
    var calledShowMovies = false
    var calledReloadMovies = false
    var calledShowError = false
    var calledIndexPath: IndexPath?
    
    func showLoading() {}
    
    func hideLoading() {}
    
    func showMoviesGrid() {
        calledShowMovies = true
    }
    
    func hideMoviesGrid() {}
    
    func reloadMoviesGrid() {
        calledReloadMovies = true
    }
    
    func showError() {
        calledShowError = true
    }
    
    func hideError() {
    }
    
    func pushDetailViewController(with movie: MovieModel) {
    }
    
    func reloadRow(at indexPath: IndexPath) {
        calledIndexPath = indexPath
    }
}

class MockMoviesClient: MoviesListClientProtocol {
    
    var movies: [MoviesPage] = {
        let bundle = Bundle(for: MoviesListPresenterTest.self)
        let url = bundle.url(forResource: "MoviesListPage1", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: jsonData)
        return [object.results]
    }()
    
    var result: ResultType<Int> = .success(2)
    
    required init(httpService: HTTPServicesProtocol = HTTPServices(),
                  coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker()) { }
    
    func getMovies(completion: @escaping ((ResultType<Int>) -> Void)) {
        completion(result)
    }
}
