//
//  FavoviteMovieListPresenter.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 11/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

final class FavoviteMovieListPresenter: FavoviteMovieListPresenterProtocol {
    
    weak var viewProtocol: FavoviteMovieListViewProtocol?
    private let favoriteMoviesClient: FavoriteMoviesClientProtocol
    
    var favoriteMovieList: [MovieModel] = []
    
    init(favoriteMoviesClient: FavoriteMoviesClientProtocol = FavoriteMoviesClient()) {
        self.favoriteMoviesClient = favoriteMoviesClient
    }
    
    func attachView(_ view: FavoviteMovieListViewProtocol) {
        self.viewProtocol = view
    }
    
    func didDeleteRow(at indexPath: IndexPath) {
        deleteMovie(at: indexPath.row)
    }
    
    func viewDidAppear() {
        fetchFavoriteMovies()
    }
    
    func didTouchRemoveFilterButton() {
        viewProtocol?.setRemoveFilterButtonHidden(true)
    }
    
}

// MARK: - Funcs

extension FavoviteMovieListPresenter {
    
    private func fetchFavoriteMovies() {
        favoriteMoviesClient.getFavoriteMovieList() { [weak self] result in
            if case let .success(list) = result {
                self?.favoriteMovieList = list
                self?.viewProtocol?.reloadData()
            }
        }
    }
    
    private func deleteMovie(at index: Int) {
        let movieMO = favoriteMovieList[index]
        favoriteMoviesClient.removeFromFavorites(movieMO, completion: { [weak self] result in
            if case .success(_) = result {
                self?.favoriteMovieList.remove(at: index)
                self?.viewProtocol?.reloadData()
            }
        })
    }
    
    private func getDateFilters() -> [String] {
        let allDates = favoriteMovieList.compactMap({ $0.releaseYear })
        return allDates
    }
    
    private func getGenreFilters() -> [String] {
        let allGenres = favoriteMovieList.flatMap{ $0.cachedGenres.map({ $0.name }) }
        return allGenres
    }
    
}
