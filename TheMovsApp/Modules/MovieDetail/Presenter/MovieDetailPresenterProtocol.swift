//
//  MovieDetailPresenterProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 07/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterProtocol: class {
    init(with movie: MovieModel, coreDataWorker: CoreDataWorkerProtocol, genreClient: GenreClientProtocol)
    func attachView(_ view: MovieDetailViewProtocol?)
    func viewDidLoad()
    func didTouchFavoriteMovie()
}
