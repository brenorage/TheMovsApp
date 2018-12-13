//
//  FavoviteMovieListPresenterProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol FavoviteMovieListPresenterProtocol: class {
    var viewProtocol: FavoviteMovieListViewProtocol? { get }
    var favoriteMovieList: [MovieModel] { get }
    func didDeleteRow(at indexPath: IndexPath)
    func attachView(_ view: FavoviteMovieListViewProtocol)
    func viewDidAppear()
    func didTouchRemoveFilterButton()
    func openFilterVC()
}
