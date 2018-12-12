//
//  MoviesGridClient.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

internal typealias MoviesPage = [MovieModel]

protocol MoviesGridClientProtocol {
    var movies: [MoviesPage] { get }
    init(httpService: HTTPServicesProtocol, coreDataWorker: CoreDataWorkerProtocol)
    func getMovies(completion: @escaping ((ResultType<Int>) -> Void))
    func setupFavoriteMovies(completion: @escaping(() -> Void))
}

class MoviesGridClient: MoviesGridClientProtocol {
    
    private let httpService: HTTPServicesProtocol
    private let coreDataWorker: CoreDataWorkerProtocol
    private var favoriteMoviesId: [Int] = []
    
    var movies: [MoviesPage] = []
    var nextPage: Int = 1
    var totalPages: Int = 2
    
    required init(httpService: HTTPServicesProtocol = HTTPServices(),
                  coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker()) {
        
        self.httpService = httpService
        self.coreDataWorker = coreDataWorker
    }
    
    func getMovies(completion: @escaping ((ResultType<Int>) -> Void)) {
        if nextPage > totalPages { return completion(.failure) }
        
        guard let moviesURL = TMDBEndpoint.popularMovies(page: nextPage).endpoint else { return completion(.failure) }
        
        httpService.get(url: moviesURL) { [weak self] (result: ResultType<MoviesListModel>) in
            switch result {
            case let .success(moviesListModel):
                self?.addMoviesPage(with: moviesListModel)
                completion(.success(moviesListModel.page))
            case .failure:
                completion(.failure)
            }
        }
    }
    
    func setupFavoriteMovies(completion: @escaping(() -> Void)) {
        coreDataWorker.fetchAll() { [weak self] (result: ResultType<[MovieMO]>) in
            if case let .success(savedMovies) = result {
                self?.favoriteMoviesId = savedMovies.map({ Int($0.movieId) })
                self?.updateFavoriteMovies()
                completion()
            }
        }
    }
    
    private func addMoviesPage(with listModel: MoviesListModel) {
        movies.append(listModel.results)
        nextPage = listModel.page + 1
        totalPages = listModel.totalPages
    }
    
    private func updateFavoriteMovies() {
        let allMovies = movies.flatMap({ $0 })
        allMovies.forEach { movie in
            movie.isFavorite = favoriteMoviesId.contains(movie.movieId ?? 0)
        }
    }
    
}
