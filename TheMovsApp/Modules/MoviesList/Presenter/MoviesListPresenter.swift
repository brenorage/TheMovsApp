//
//  MoviesListPresenter.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesListPresenter: MoviesListPresenterProtocol {
    
    private weak var viewProtocol: MoviesGridViewProtocol?
    private var moviesClient: MoviesListClientProtocol
    
    var moviesPages: [MoviesPage] = []
    
    init(viewProtocol: MoviesGridViewProtocol, moviesClient: MoviesListClientProtocol = MoviesListClient()) {
        self.viewProtocol = viewProtocol
        self.moviesClient = moviesClient
    }
}

//MARK: List methods
extension MoviesListPresenter {
    func getList() {
        moviesClient.getMovies { result in
            switch result {
            case let .success(moviesPage):
                break
            case .failure:
                break
            }
        }
    }
}
