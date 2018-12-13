//
//  FavoviteMovieListViewProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol FavoviteMovieListViewProtocol: class {
    func reloadData()
    func pushDetailViewController(with movie: MovieModel)
    func setRemoveFilterButtonHidden(_ isHidden: Bool)
    func showMoviesTableView()
    func hideMoviesTableView()
    func showError(with errorModel: GenericErrorModel)
    func hideError()
    func changeDataSourceState(with state: SearchState)
    func openNavigation(with vc: UIViewController)
}
