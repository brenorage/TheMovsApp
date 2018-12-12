//
//  MoviesListPresenter.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    weak var viewProtocol: MoviesGridViewProtocol?
    private var moviesClient: MoviesListClientProtocol
    private var tmdbConfigClient = TMDBConfigurationClient()
    
    var moviesPages: [MoviesPage] {
        return moviesClient.movies
    }
 
    init(moviesClient: MoviesListClientProtocol = MoviesListClient()) {
        self.moviesClient = moviesClient
    }

}

//MARK: List methods
extension MoviesListPresenter {
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
    
    private func treatSuccess() {
        viewProtocol?.showMoviesGrid()
        viewProtocol?.reloadMoviesGrid()
    }
    
    private func getConfigModel() {
        tmdbConfigClient.getConfigurationModel(completion: nil)
    }
    
    private func treatError() {
        viewProtocol?.hideMoviesGrid()
        viewProtocol?.showError()
    }

}

// MARK: - FavoriteMovieDelegate

extension MoviesListPresenter: FavoriteMovieDelegate {
    
    func didFavoriteMovie(_ movieId: Int) {
        let allMoviesArray = moviesPages.flatMap({ $0 })
        if let indexPath = allMoviesArray
                                .enumerated()
                                    .filter({ $1.movieId == movieId })
                                      .map({ return IndexPath(item: $0.offset, section: 0) })
                                        .first {
            
            viewProtocol?.reloadRow(at: indexPath)
        }
    }
    
}
