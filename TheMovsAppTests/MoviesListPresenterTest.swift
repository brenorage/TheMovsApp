//
//  MoviesGridPresenterTest.swift
//  TheMovsAppTests
//
//  Created by Breno Rage Aboud on 05/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest

@testable import TheMovsApp

class MoviesGridPresenterTest: XCTestCase {

    var presenter: MoviesGridPresenter!
    var viewMock = MockMoviesListView()
    var clientMock = MockMoviesClient()
    
    override func setUp() {
        presenter = MoviesGridPresenter(moviesClient: clientMock)
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
    
    func testIfPresenterCanSearchAMovie() {
        presenter.getList()
        presenter.filterSearch(with: "Venom")
        XCTAssert(presenter.filteredMovies.contains { $0.title == "Venom" })
    }
    
    func testIfPresenterClearFilteredMoviesWhenUserInputLessThanThreeCaracthers() {
        presenter.getList()
        presenter.filterSearch(with: "Venom")
        presenter.filterSearch(with: "")
        XCTAssert(presenter.filteredMovies.isEmpty)
    }
    
    func testIfPresenterManipulatesListCorrectlyWhenUserClearSearchText() {
        presenter.getList()
        presenter.filterSearch(with: "Venom")
        presenter.filterSearch(with: "Ven")
        XCTAssert(presenter.filteredMovies.count == 1)
    }
    
    func testIfPresenterCallEmptyStateWithEmptySearch() {
        presenter.getList()
        presenter.filterSearch(with: "Vazio")
        XCTAssert(viewMock.calledShowEmptyState)
    }
}

class MockMoviesListView: MoviesGridViewProtocol {
    
    var calledShowMovies = false
    var calledReloadMovies = false
    var calledShowError = false
    var calledShowEmptyState = false
    
    func showLoading() {}
    
    func hideLoading() {}
    
    func showMoviesGrid() {
        calledShowMovies = true
    }
    
    func hideMoviesGrid() {}
    
    func reloadMoviesGrid() {
        calledReloadMovies = true
    }
    
    func showError(with errorModel: GenericErrorModel) {
        if errorModel.imageName == "errorImage" {
            calledShowError = true
        } else if errorModel.imageName == "searchIcon" {
            calledShowEmptyState = true
        }
    }
    
    func hideError() {
    }
    
    func pushDetailViewController(with movie: MovieModel) {
    }
    
    func changeDataSourceState(with state: MoviesCollectionViewDataSource.State) {}
}

class MockMoviesClient: MoviesGridClientProtocol {
    
    var movies: [MoviesPage] = []
    
    var result: ResultType<Int> = .success(2)
    
    required init(httpService: HTTPServicesProtocol = HTTPServices()) { }
    
    func getMovies(completion: @escaping ((ResultType<Int>) -> Void)) {
        let filePath = Bundle(for: MoviesGridViewSpec.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: data)
        movies.append(object.results)
        completion(result)
    }
}
