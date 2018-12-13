//
//  FavoviteMovieListViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 11/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoviteMovieListViewController: UIViewController {
    
    private let screen = FavoviteMovieListScreen()
    private var presenter: FavoviteMovieListPresenterProtocol
    private var dataSource: FavoriteMoviesTableViewDataSource
    private var delegate: FavoriteMoviesTableViewDelegate
    
    init(presenter: FavoviteMovieListPresenterProtocol = FavoviteMovieListPresenter()) {
        self.delegate = FavoriteMoviesTableViewDelegate(presenter: presenter)
        self.dataSource = FavoriteMoviesTableViewDataSource(presenter: presenter)
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.attachView(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupListView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidAppear()
    }
    
}

// MARK: - Funcs

extension FavoviteMovieListViewController {
    
    private func setupListView() {
        screen.tableView.register(FavoriteListTableViewCell.self)
        screen.tableView.dataSource = dataSource
        screen.tableView.delegate = delegate
    }
    
}

// MARK: - FavoviteMovieListViewProtocol

extension FavoviteMovieListViewController: FavoviteMovieListViewProtocol {
    
    func reloadData() {
         DispatchQueue.main.async {
            self.screen.tableView.reloadData()
        }
    }
    
    func pushDetailViewController(with movie: MovieModel) {
        let movieDetail = MovieDetailViewController(with: movie)
        navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func setRemoveFilterButtonHidden(_ isHidden: Bool) {
        screen.setRemoveFilterButtonHidden(true)
    }
    
}

// MARK: - FavoviteMovieRemoveFilterDelegate

extension FavoviteMovieListViewController: FavoviteMovieRemoveFilterDelegate {
    func didTouchRemoveFilterButton() {
        presenter.didTouchRemoveFilterButton()
    }
}
