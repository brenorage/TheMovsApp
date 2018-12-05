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
    
    private func treatSuccess(with pageIndex: Int) {
        viewProtocol?.showMoviesGrid()
        viewProtocol?.reloadMoviesGrid(with: pageIndex)
    }
}
