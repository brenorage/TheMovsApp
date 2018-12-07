//
//  MovieDetailPresenter.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 07/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    private weak var view: MovieDetailViewProtocol?
    
    private let movie: MovieModel
    private let coreDataWorker: CoreDataWorkerProtocol
    private let genreClient: GenreClientProtocol
    
    required init(with movie: MovieModel,
         coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker(),
            genreClient: GenreClientProtocol = GenreClient()) {
        
        self.movie = movie
        self.coreDataWorker = coreDataWorker
        self.genreClient = genreClient
    }
    
    func attachView(_ view: MovieDetailViewProtocol?) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setScreenTitle("Movie")
        view?.fillMovieTitle(with: movie.title)
        view?.fillMovieYear(with: movie.releaseYear)
        view?.fillMovieBackdrop(with: "")
        getSavedGenres()
    }
    
}

// MARK: - Private functions

extension MovieDetailPresenter {
    
    // Pega o array de generos salvos no Core Data
    private func getSavedGenres() {
        coreDataWorker.fetchAll() { [weak self] (result: ResultType<[GenreMO]>) in
            if case let .success(genres) = result {
               self?.handleSavedGenres(with: genres)
            }
        }
    }
    
    //Faz request para baixar a lista de generos
    private func downloadGenres() {
        genreClient.getGenres() { [weak self] (result: ResultType<Bool>) in
            if case .success(_) = result {
                self?.getSavedGenres()
            }
        }
    }
    
    //Faz o tratamento do array filtrado para retornar os generos
    //no formato "xxx, xxx, xxx"
    private func handleSavedGenres(with savedGenres: [GenreMO]) {
        if savedGenres.count > 0 { // Possui generos salvos
            let filteredGenres = savedGenres.filter({ movie.genreIds.contains(Int($0.genreId)) }).map({ $0.name })
            let genresString = filteredGenres.joined(separator: ", ")
            DispatchQueue.main.async {
                self.view?.fillMovieGenre(with: genresString)
            }
        } else {
            downloadGenres()
        }
    }
    
}
