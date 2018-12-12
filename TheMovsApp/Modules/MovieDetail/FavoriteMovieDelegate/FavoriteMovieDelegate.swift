//
//  FavoriteMovieDelegate.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 11/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol FavoriteMovieDelegate: class {
    func didFavoriteMovie(_ movieId: Int)
}
