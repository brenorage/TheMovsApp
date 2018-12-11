//
//  MovieDetailViewControllerSpec.swift
//  TheMovsAppTests
//
//  Created by André Souza on 09/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
import Quick
import Nimble
import Nimble_Snapshots
@testable import TheMovsApp

final class MovieDetailViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("a 'MovieDetailViewController'") {
            
            var presenterStub: MovieDetailPresenterProtocol!
            var sut: MovieDetailViewController!
            var movieStub: MovieModel!
            
            beforeEach {
                movieStub = self.getMovie()
                presenterStub = PresenterStub(with: movieStub)
                sut = MovieDetailViewController(presenter: presenterStub)
                presenterStub.attachView(sut)
            }
            
            it("should have the expected look and feel with movie mock") {
//                expect(sut).toEventually(recordSnapshot(named: "MovieDetailViewController"))
                expect(sut).toEventually(haveValidSnapshot(named: "MovieDetailViewController"))
            }
            
            
        }
    }
    
    private func getMovie() -> MovieModel {
        let bundle = Bundle(for: MovieDetailPresenterSpec.self)
        let url = bundle.url(forResource: "MovieDetail", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(MovieModel.self, from: jsonData)
    }
    
    
}


private final class PresenterStub: MovieDetailPresenterProtocol {
 
    weak var view: MovieDetailViewProtocol?
    let movie: MovieModel
    
    init(with movie: MovieModel,
         coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker(),
         genreClient: GenreClientProtocol = GenreClient()) {
        self.movie = movie
    }
    
    func attachView(_ view: MovieDetailViewProtocol?) {
        self.view = view
    }
    
    func didTouchFavoriteMovie() { }
    
    func viewDidLoad() {
        view?.setScreenTitle("Movie")
        view?.fillMovieTitle(with: movie.title)
        view?.fillMovieYear(with: movie.releaseYear)
        view?.fillMoviePlot(with: movie.overview)
        view?.fillMovieBackdrop(with: movie.getBackdropURL())
        view?.fillMovieGenre(with: "Adventure, Horror")
        view?.setFavorite(movie.isFavorite)
        view?.setGenreInfoHidden(false)
    }
    
}
