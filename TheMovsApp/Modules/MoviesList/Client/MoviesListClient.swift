//
//  MoviesListClient.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesListClient {
    
    typealias MoviesPage = [MovieModel]
    
    private let httpService: HTTPServicesProtocol
    var movies: [MoviesPage] = []
    var nextPage: Int = 1
    var totalPages: Int = 2
    
    init(httpService: HTTPServicesProtocol = HTTPServices()) {
        self.httpService = httpService
    }
    
    func getMovies(completion: @escaping ((RequestResultType<MoviesPage>) -> Void)) {
        if nextPage > totalPages { return completion(.failure) }
        
        guard let moviesURL = TMDBEndpoint.popularMovies(page: nextPage).endpoint else { return completion(.failure) }
        
        httpService.get(url: moviesURL) { [weak self] (result: RequestResultType<MoviesListModel>) in
            switch result {
            case let .success(moviesListModel):
                self?.addMoviesPage(with: moviesListModel)
                completion(.success(moviesListModel.results))
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
}
