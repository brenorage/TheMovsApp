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
        view?.fillMoviePlot(with: movie.overview)
        view?.setFavorite(movie.isFavorite)
        setupBackdrop()
        setupGenres()
    }
    
    func didTouchFavoriteMovie() {
        if !movie.isFavorite {
            saveMovie()
        } else {
            findSavedMovie()
        }
    }
    
}

// MARK: - Private functions

extension MovieDetailPresenter {
    
    private func setupBackdrop() {
        if let backdropUrl = movie.getBackdropURL() {
            view?.fillMovieBackdrop(with: backdropUrl)
        }
    }
    
    private func setupGenres() {
        if movie.cachedGenres.isEmpty {
            getSavedGenres(downloadIfEmpty: true)
        } else {
            treatGenreInfo()
        }
    }
    
    // Pega o array de generos salvos no Core Data
    private func getSavedGenres(downloadIfEmpty: Bool) {
        coreDataWorker.fetchAll() { [weak self] (result: ResultType<[GenreMO]>) in
            if case let .success(genres) = result {
                if !genres.isEmpty {
                    self?.handleSavedGenres(with: genres)
                } else if downloadIfEmpty {
                    self?.downloadGenres()
                }
            }
        }
    }
    
    //Faz request para baixar a lista de generos
    private func downloadGenres() {
        genreClient.getGenres() { [weak self] result in
            if case .success(_) = result {
                self?.getSavedGenres(downloadIfEmpty: false)
            }
        }
    }
    
    //Faz o tratamento do array filtrado para retornar os generos
    //no formato "xxx, xxx, xxx"
    private func handleSavedGenres(with savedGenres: [GenreMO]) {
        guard let genreIds = movie.genreIds else { return }
         // Possui generos salvos
        let filteredGenres = savedGenres.filter({ genreIds.contains(Int($0.genreId)) })
        movie.cachedGenres = filteredGenres
        treatGenreInfo()
    }
    
    private func treatGenreInfo() {
        let genresString = movie.cachedGenres.map({ $0.name }).joined(separator: ", ")
        view?.fillMovieGenre(with: genresString)
        view?.setGenreInfoHidden(false)
    }
    
    private func saveMovie() {
        guard let movieId = movie.movieId else { return }
        
        let movieMO = MovieMO()
        movieMO.movieId = Int32(movieId)
        movieMO.title = movie.title
        movieMO.year = movie.releaseDate
        movieMO.overview = movie.overview
        movieMO.posterPath = movie.posterPath
        movieMO.backdropPath = movie.backdropPath
        movieMO.genres = Set(movie.cachedGenres)
        
        saveCoreDataChanges()
    }
    
    private func findSavedMovie() {
        guard let movieId = movie.movieId else { return }
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["movieId", movieId])
        coreDataWorker.fetch(with: predicate) { [weak self] (result: ResultType<[MovieMO]>) in
            if case let .success(movies) = result, let movie = movies.first {
                self?.deleteMovie(movie)
            }
        }
    }
    
    private func deleteMovie(_ movieMO: MovieMO) {
        coreDataWorker.delete(enity: movieMO) { result in
            if case .success(_) = result {
                self.saveCoreDataChanges()
            }
        }
    }
    
    private func saveCoreDataChanges() {
        do {
            try coreDataWorker.save()
            movie.isFavorite.toggle()
            view?.setFavorite(movie.isFavorite)
        } catch {
            debugPrint("MovieDetailPresenter: Save context error: \(error)")
        }
    }
    
}
