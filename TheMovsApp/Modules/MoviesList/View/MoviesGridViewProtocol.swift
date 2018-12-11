//
//  MoviesGridViewProtocol.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MoviesGridViewProtocol: class {
    func showLoading()
    func hideLoading()
    func showMoviesGrid()
    func hideMoviesGrid()
    func reloadMoviesGrid()
    func showError()
    func hideError()
    func pushDetailViewController(with movie: MovieModel)
}
