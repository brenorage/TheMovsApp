//
//  MovieDetailViewProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 07/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MovieDetailViewProtocol: class {
    init(with movie: MovieModel)
    func setScreenTitle(_ title: String)
    func fillMovieTitle(with title: String?)
    func fillMovieYear(with year: String?)
    func fillMovieGenre(with genre: String)
    func fillMoviePlot(with plot: String?)
    func fillMovieBackdrop(with url: URL?)
    func setFavorite(_ isFavorite: Bool)
    func setGenreInfoHidden(_ isHidden: Bool)
    var favoriteDelegate: FavoriteMovieDelegate? { get set }
}
