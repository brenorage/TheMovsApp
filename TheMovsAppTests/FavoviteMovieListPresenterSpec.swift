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
    
    override func setUp() {
        favoriteListClientStub = FavoriteClientStub(coreDataWorker: CoreDataWorker())
        sut = FavoviteMovieListPresenter(favoriteMoviesClient: favoriteListClientStub)
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
    
    func testSearchMovieShouldReturnFilteredList() {
        sut.viewDidAppear()
        sut.filterSearch(with: "Fan")
        XCTAssertEqual(sut.filteredMovies.first!.title, "Fantastic Beasts: The Crimes of Grindelwald")
    }
    
    func testSearchEmptyTextShouldClearTheFilteredList() {
        sut.viewDidAppear()
        sut.filterSearch(with: "Fantas")
        sut.filterSearch(with: "")
        XCTAssertEqual(sut.filteredMovies.count, 0)
    }
    
    
}


private final class FavoriteClientStub: FavoriteMoviesClientProtocol {
    
    init(coreDataWorker: CoreDataWorkerProtocol) { }
    
    func getFavoriteMovieList(completion: @escaping ((ResultType<[MovieModel]>) -> Void)) {
        let filePath = Bundle(for: FavoviteMovieListPresenterSpec.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: data)
        completion(.success(object.results))
    }
    
    func removeFromFavorites(_ movie: MovieModel, completion: @escaping ((ResultType<Bool>) -> Void)) {
        completion(.success(true))
    }
    
    
}
