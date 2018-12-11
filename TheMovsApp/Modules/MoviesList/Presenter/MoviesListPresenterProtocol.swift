//
//  MoviesListPresenterProtocol.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MoviesListPresenterProtocol: class {
    var moviesPages: [MoviesPage] { get }
    var viewProtocol: MoviesGridViewProtocol? { set get }
    func getList()
    func getMoreMovies()
}

