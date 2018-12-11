//
//  MoviesGridPresenter.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesGridPresenter: MoviesGridPresenterProtocol {
    
    weak var viewProtocol: MoviesGridViewProtocol?
    private var moviesClient: MoviesGridClientProtocol
    private var tmdbConfigClient = TMDBConfigurationClient()
    var filteredMovies: MoviesPage = []
    
    var moviesPages: [MoviesPage] {
        return moviesClient.movies
    }
    
    init(moviesClient: MoviesGridClientProtocol = MoviesGridClient()) {
        self.moviesClient = moviesClient
    }
}

//MARK: List methods
extension MoviesGridPresenter {
    func getList() {
        viewProtocol?.showLoading()
        getConfigModel()
        moviesClient.getMovies { [weak self] result in
            self?.viewProtocol?.hideLoading()
            switch result {
            case .success(_):
                self?.viewProtocol?.showMoviesGrid()
            case .failure:
                self?.treatError()
            }
        }
    }
    
    func getMoreMovies() {
        moviesClient.getMovies { [weak self] result in
            switch result {
            case .success(_):
                self?.treatSuccess()
            case .failure:
                break
            }
        }
    }
    
    func filterSearch(with text: String?) {
        if  let searchText = text,
            searchText.count >= 3 {
            var moviesFromSearch = getMoviesFromSearch(with: searchText)
            moviesFromSearch = moviesFromSearch.filter { movie in
                !filteredMovies.contains { $0.title == movie.title } }
            filteredMovies.append(contentsOf: moviesFromSearch)
        } else {
            filteredMovies = []
        }
        
        viewProtocol?.reloadMoviesGrid()
    }
    
    private func getMoviesFromSearch(with text: String) -> MoviesPage {
        var movies: MoviesPage = []
        moviesPages.forEach {
            movies.append(contentsOf: $0.filter { $0.title.contains(text) })
        }
        return movies
    }
    
    private func treatSuccess() {
        viewProtocol?.showMoviesGrid()
        viewProtocol?.reloadMoviesGrid()
    }
    
    private func getConfigModel() {
        tmdbConfigClient.getConfigurationModel(completion: nil)
    }
    
    private func treatError() {
        let errorModel = GenericErrorModel(imageName: "errorImage", imageColor: .red, message: "Um error ocorreu. Por favor, tente novamente mais tarde.")
        viewProtocol?.hideMoviesGrid()
        viewProtocol?.showError(with: errorModel)
    }
}
