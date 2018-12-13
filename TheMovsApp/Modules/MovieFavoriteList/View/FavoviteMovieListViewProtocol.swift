//
//  FavoviteMovieListViewProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol FavoviteMovieListViewProtocol: class {
    func reloadData()
    func pushDetailViewController(with movie: MovieModel)
    func setRemoveFilterButtonHidden(_ isHidden: Bool)
}
