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
                break
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
}
