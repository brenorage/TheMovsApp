//
//  FavoviteMovieListViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 11/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FavoviteMovieListViewController: UIViewController, HomeTabBarChildProtocol {
    
    private lazy var screen = FavoviteMovieListScreen(delegate: self)
    private var presenter: FavoviteMovieListPresenterProtocol
    private var dataSource: FavoriteMoviesTableViewDataSource
    private var delegate: FavoriteMoviesTableViewDelegate
    
    var rightBarButtonItem: UIBarButtonItem?
    lazy var searchResultsUpdating: UISearchResultsUpdating? = self
    
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
        setupFilterButton()
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
    
    private func setupFilterButton() {
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterIcon"), style: .plain, target: self, action: #selector(openFilterVC))
        rightBarButtonItem = filterButton
    }
    
    @objc private func openFilterVC() {
        presenter.openFilterVC()
    }
}

// MARK: - FavoviteMovieListViewProtocol

extension FavoviteMovieListViewController: FavoviteMovieListViewProtocol {
    
    func showMoviesTableView() {
        screen.tableView.isHidden = false
    }
    
    func hideMoviesTableView() {
        screen.tableView.isHidden = true
    }
    
    func showError(with errorModel: GenericErrorModel) {
        screen.setStateView(with: errorModel)
        screen.genericView.isHidden = false
        screen.layoutIfNeeded()
    }
    
    func hideError() {
        screen.genericView.isHidden = true
    }
    
    func changeDataSourceState(with state: SearchState) {
        dataSource.state = state
    }
    
    
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
        screen.setRemoveFilterButtonHidden(isHidden)
    }
    
    func openNavigation(with vc: UIViewController) {
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
    }
}

// MARK: - FavoviteMovieRemoveFilterDelegate -
extension FavoviteMovieListViewController: FavoviteMovieRemoveFilterDelegate {
    func didTouchRemoveFilterButton() {
        presenter.didTouchRemoveFilterButton()
    }
}

//MARK: - Search controller methods -
extension FavoviteMovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterSearch(with: searchController.searchBar.text)
    }
}
