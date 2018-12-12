//
//  FavoriteMoviesTableViewDataSource.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoriteMoviesTableViewDataSource: NSObject {
    let presenter: FavoviteMovieListPresenterProtocol
    
    init(presenter: FavoviteMovieListPresenterProtocol) {
        self.presenter = presenter
    }

}

extension FavoriteMoviesTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favoriteMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.favoriteMovieList[indexPath.row]
        let cell: FavoriteListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.didDeleteRow(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}
