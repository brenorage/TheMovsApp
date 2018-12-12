//
//  FavoriteMoviesClient.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol FavoriteMoviesClientProtocol {
    init(coreDataWorker: CoreDataWorkerProtocol)
    func getFavoriteMovieList(completion: @escaping ((ResultType<[MovieModel]>) -> Void))
    func removeFromFavorites(_ movie: MovieModel, completion: @escaping ((ResultType<Bool>) -> Void))
}

final class FavoriteMoviesClient: FavoriteMoviesClientProtocol {
    
    var favoriteMovieList: [MovieModel] = []
    private let coreDataWorker: CoreDataWorkerProtocol
    
    required init(coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker()) {
        self.coreDataWorker = coreDataWorker
    }
    
    func getFavoriteMovieList(completion: @escaping ((ResultType<[MovieModel]>) -> Void)) {
        coreDataWorker.fetchAll() { [weak self] (result: ResultType<[MovieMO]>) in
            if case let .success(list) = result {
                if let resultTreated = self?.treatResult(list) {
                    completion(.success(resultTreated))
                }
            } else {
                completion(.failure)
            }
        }
    }
    
    func removeFromFavorites(_ movie: MovieModel, completion: @escaping ((ResultType<Bool>) -> Void)) {
        guard let movieId = movie.movieId else { return completion(.failure) }
        findAndDeleteMovie(movieId, completion: completion)
    }
    
}

extension FavoriteMoviesClient {
    
    private func treatResult(_ result: [MovieMO]) -> [MovieModel] {
        let treatedResult: [MovieModel] = result.map({ movieMO in
            
            let movieModel = MovieModel(movieId: Int(movieMO.movieId), title: movieMO.title, overview: movieMO.overview, releaseDate: movieMO.year, posterPath: movieMO.posterPath, backdropPath: movieMO.backdropPath, isFavorite: true)
            
            if let genres = movieMO.genres {
                movieModel.cachedGenres = Array(genres)
            }
            
            return movieModel
        })
        
        return treatedResult
    }
    
    private func findAndDeleteMovie(_ movieId: Int, completion: @escaping ((ResultType<Bool>) -> Void)) {
        let predicate = NSPredicate(format: "%K == %@", argumentArray: ["movieId", movieId])
        coreDataWorker.fetch(with: predicate) { [weak self] (result: ResultType<[MovieMO]>) in
            if case let .success(movies) = result, let movie = movies.first {
                self?.deleteMovie(movie, completion: completion)
            }
        }
    }
    
    private func deleteMovie(_ movieMO: MovieMO, completion: @escaping ((ResultType<Bool>) -> Void)) {
        coreDataWorker.delete(enity: movieMO) { result in
            if case .success(_) = result {
                self.saveCoreDataChanges()
            }
            
            completion(result)
        }
    }
    
    private func saveCoreDataChanges() {
        do {
            try coreDataWorker.save()
        } catch {
            debugPrint("FavoriteMoviesClient: Save context error: \(error)")
        }
    }
    
}
