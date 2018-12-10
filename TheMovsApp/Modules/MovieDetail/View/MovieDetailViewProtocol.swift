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
    init(presenter: MovieDetailPresenterProtocol)
    func setScreenTitle(_ title: String)
    func fillMovieTitle(with title: String?)
    func fillMovieYear(with year: String?)
    func fillMovieGenre(with genre: String)
    func fillMoviePlot(with plot: String?)
    func fillMovieBackdrop(with url: URL?)
    func setGenreInfoHidden(_ isHidden: Bool) 
}
