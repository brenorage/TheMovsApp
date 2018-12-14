//
//  FavoriteMoviesTableViewDelegate.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoriteMoviesTableViewDelegate: NSObject {
    private var presenter: FavoviteMovieListPresenterProtocol
    
    var state: SearchState = .normal
    
    init(presenter: FavoviteMovieListPresenterProtocol) {
        self.presenter = presenter
    }
}

extension FavoriteMoviesTableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch state {
        case .normal:
            let movie = presenter.favoriteMovieList[indexPath.row]
            presenter.viewProtocol?.pushDetailViewController(with: movie)
        case .search:
            let movie = presenter.filteredMovies[indexPath.row]
            presenter.viewProtocol?.pushDetailViewController(with: movie)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
}
