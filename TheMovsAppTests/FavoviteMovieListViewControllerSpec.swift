//
//  FavoviteMovieListViewControllerSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 13/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Nimble_Snapshots
@testable import TheMovsApp

final class FavoviteMovieListViewControllerSpec: QuickSpec {

    override func spec() {

        describe("a 'FavoviteMovieListViewController'") {

            var presenterStub: PresenterStub!
            var sut: FavoviteMovieListViewController!

            beforeEach {
                presenterStub = PresenterStub()
                presenterStub.favoriteMovieList = self.getFavoriteMovieList()
                sut = FavoviteMovieListViewController(presenter: presenterStub)
                sut.view.frame = UIScreen.main.bounds
            }

            it("should have the expected look and feel") {
//                expect(sut) == recordSnapshot("FavoviteMovieListViewController")
                expect(sut)  == snapshot("FavoviteMovieListViewController")
            }


        }
    }

    func getFavoriteMovieList() -> [MovieModel] {
        let filePath = Bundle(for: FavoviteMovieListViewControllerSpec.self).path(forResource: "MoviesListPage1", ofType: ".json")!
        let fileUrl = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl, options: .alwaysMapped)
        let object = try! JSONDecoder().decode(MoviesListModel.self, from: data)
        return object.results
    }


}

private final class PresenterStub: FavoviteMovieListPresenterProtocol {
    
    weak var viewProtocol: FavoviteMovieListViewProtocol?

    var favoriteMovieList: [MovieModel] = []
    var filteredMovies: MoviesPage = []


    func didDeleteRow(at indexPath: IndexPath) {

    }

    func attachView(_ view: FavoviteMovieListViewProtocol) {
        self.viewProtocol = view
    }

    func viewDidAppear() {
        viewProtocol?.reloadData()
    }

    func didTouchRemoveFilterButton() {
        
    }
    
    func filterSearch(with text: String?) {
        
    }
    
    func openFilterVC() {
        
    }
    
}
