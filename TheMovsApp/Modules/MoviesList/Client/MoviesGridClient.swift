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
                self?.setupFavoriteMovies(with: moviesListModel.results)
                self?.addMoviesPage(with: moviesListModel)
                completion(.success(moviesListModel.page))
            case .failure:
                completion(.failure)
            }
        }
    }
    
    private func addMoviesPage(with listModel: MoviesListModel) {
        movies.append(listModel.results)
        nextPage = listModel.page + 1
        totalPages = listModel.totalPages
    }
    
    private func setupFavoriteMovies(with movies: [MovieModel]) {
        if favoriteMoviesId.isEmpty {
            coreDataWorker.fetchAll() { [weak self] (result: ResultType<[MovieMO]>) in
                if case let .success(savedMovies) = result {
                    self?.favoriteMoviesId = savedMovies.map({ Int($0.movieId) })
                    self?.favoriteMovies(movies)
                }
            }
        } else {
            favoriteMovies(movies)
        }
    }
    
    private func favoriteMovies(_ movies: [MovieModel]) {
        let favoriteMovies = movies.filter({ self.favoriteMoviesId.contains($0.movieId ?? 0) })
        favoriteMovies.forEach { $0.isFavorite = true }
    }
    
}
