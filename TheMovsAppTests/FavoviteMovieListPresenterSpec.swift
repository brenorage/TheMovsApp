//
//  FavoviteMovieListPresenterSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 13/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
@testable import TheMovsApp

final class FavoviteMovieListPresenterSpec: XCTestCase {
    
    private var sut: FavoviteMovieListPresenter!
    private var favoriteListClientStub: FavoriteClientStub!
    private var viewProtocol: MockFavoriteMovieListView!
    
    override func setUp() {
        viewProtocol = MockFavoriteMovieListView()
        favoriteListClientStub = FavoriteClientStub(coreDataWorker: CoreDataWorker())
        sut = FavoviteMovieListPresenter(favoriteMoviesClient: favoriteListClientStub)
        sut.attachView(viewProtocol)
    }
    
    func testViewDidAppearShouldFetchFavoriteMoviesList() {
        sut.viewDidAppear()
        XCTAssertGreaterThan(sut.favoriteMovieList.count, 0)
    }
    
    func testDeleteMovieAtIndexPathShouldRemoveMovieFromArray() {
        sut.viewDidAppear()
        let indexPath = IndexPath(row: 0, section: 0)
        sut.didDeleteRow(at: indexPath)
        XCTAssertEqual(sut.favoriteMovieList.count, 1)
    }
    
    func testIfPresenterCalledFilterWithCorrectParams() {
        sut.viewDidAppear()
        sut.openFilterVC()
        let expectedYears = ["2018"]
        let expectedGenres = ["Science Fiction"]
        let filterYear = FilterModel(filterType: "Data", options: expectedYears)
        let filterGenre = FilterModel(filterType: "Genero", options: expectedGenres)
        let filterModels = [filterYear, filterGenre]
        let vc = viewProtocol.calledFilterVC as! FilterViewController
        XCTAssert(vc.model == filterModels)
    }
}


private final class FavoriteClientStub: FavoriteMoviesClientProtocol {
    
    init(coreDataWorker: CoreDataWorkerProtocol) { }
    
    func getFavoriteMovieList(completion: @escaping ((ResultType<[MovieModel]>) -> Void)) {
        let filePath = Bundle(for: FavoviteMovieListPresenterSpec.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: data)
        object.results.forEach {
            let genre = GenreMO()
            genre.genreId = 878
            genre.name = "Science Fiction"
            $0.cachedGenres.append(genre)
        }
        completion(.success(object.results))
    }
    
    func removeFromFavorites(_ movie: MovieModel, completion: @escaping ((ResultType<Bool>) -> Void)) {
        completion(.success(true))
    }
}

final class MockFavoriteMovieListView: FavoviteMovieListViewProtocol {
    
    var calledFilterVC: UIViewController!
    
    func reloadData() {}
    
    func pushDetailViewController(with movie: MovieModel) {}
    
    func setRemoveFilterButtonHidden(_ isHidden: Bool) {}
    
    func showMoviesTableView() {}
    
    func hideMoviesTableView() {}
    
    func showError(with errorModel: GenericErrorModel) {}
    
    func hideError() {}
    
    func changeDataSourceState(with state: SearchState) {}
    
    func openNavigation(with vc: UIViewController) {
        calledFilterVC = vc
    }
}
