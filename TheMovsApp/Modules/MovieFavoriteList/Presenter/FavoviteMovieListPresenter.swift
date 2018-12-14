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
    var filteredMovies: MoviesPage = []
    
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
        viewProtocol?.changeDataSourceState(with: .normal)
        viewProtocol?.reloadData()
        filteredMovies = []
    }
    
    func filterSearch(with text: String?) {
        guard let searchText = text else { return }
        if searchText.count >= 3 {
            let moviesFromSearch = getMoviesFromSearch(with: searchText)
            viewProtocol?.changeDataSourceState(with: .search)
            if moviesFromSearch.isEmpty {
                showEmptySearch(with: searchText)
            } else {
                filteredMovies = moviesFromSearch
                viewProtocol?.hideError()
                viewProtocol?.showMoviesTableView()
                viewProtocol?.reloadData()
            }
            
        } else if searchText.isEmpty {
            filteredMovies = []
            viewProtocol?.changeDataSourceState(with: .normal)
            viewProtocol?.hideError()
            viewProtocol?.showMoviesTableView()
            viewProtocol?.reloadData()
        }
    }
    
    func openFilterVC() {
        let yearFilterModel = FilterModel(filterType: "Data", options: getDateFilters())
        let genreFilterModel = FilterModel(filterType: "Genero", options: getGenreFilters())
        let filterVC = FilterViewController(with: [yearFilterModel, genreFilterModel], filterState: .filterType, filterDelegate: self)
        viewProtocol?.openNavigation(with: filterVC)
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
        let allDatesWithoutDuplicates = Array(Set(allDates))
        return allDatesWithoutDuplicates
    }
    
    private func getGenreFilters() -> [String] {
        let allGenres = favoriteMovieList.flatMap{ $0.cachedGenres.map({ $0.name }) }
        let allGenresWithoutDuplicates = Array(Set(allGenres))
        return allGenresWithoutDuplicates
    }
    
    private func filterMovies(with params: FilterParams) {
        if !params.isEmpty {
            var movies: [MovieModel] = []
            
            let moviesPerYear = Set(favoriteMovieList.filter { $0.releaseYear == params["Data"] })
            let moviesPerGenre = Set(favoriteMovieList.filter { $0.cachedGenres.contains(where: { $0.name == params["Genero"] }) })
            
            movies.append(contentsOf: moviesPerYear)
            movies.append(contentsOf: moviesPerGenre)
            
            if  !moviesPerYear.isEmpty,
                !moviesPerGenre.isEmpty {
                movies = Array(moviesPerYear.intersection(moviesPerGenre))
            }
            
            filteredMovies = movies
//            var movies = favoriteMovieList.filter { $0.releaseYear == params["Data"] }
//
//            movies.append(contentsOf: favoriteMovieList.filter { $0.cachedGenres.contains(where: { $0.name == params["Genero"] }) })
            
//            filteredMovies = Array(Set(movies))
            
            viewProtocol?.changeDataSourceState(with: .search)
            viewProtocol?.reloadData()
        }
    }
    
    private func getMoviesFromSearch(with text: String) -> MoviesPage {
        let movies = favoriteMovieList.filter({
            guard let title = $0.title else { return false }
            return title.contains(text)
        })
        return movies
    }
    
    private func showEmptySearch(with text: String) {
        let emptyState = GenericErrorModel(imageName: "searchIcon", imageColor: .black, message: "Sua busca por \(text) não resultou em nenhum resultado.")
        viewProtocol?.hideMoviesTableView()
        viewProtocol?.showError(with: emptyState)
    }
    
}

//MARK: - Filter delegate -
extension FavoviteMovieListPresenter: FilterViewDelegate {
    func didFinishFilter(with params: FilterParams) {
        viewProtocol?.setRemoveFilterButtonHidden(false)
        filterMovies(with: params)
    }
}
