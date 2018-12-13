//
//  MoviesGridViewController.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesGridViewController: UIViewController {
    
    private let moviesGridView = MoviesGridView()
    
    private var delegate: MoviesCollectionViewDelegate
    private var dataSource: MoviesCollectionViewDataSource
    private var presenter: MoviesGridPresenterProtocol
    
    init(presenter: MoviesGridPresenterProtocol = MoviesGridPresenter()) {
        self.presenter = presenter
        dataSource = MoviesCollectionViewDataSource(presenter: presenter)
        delegate = MoviesCollectionViewDelegate(presenter: presenter)
        super.init(nibName: nil, bundle: nil)
        self.presenter.viewProtocol = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = moviesGridView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideMoviesGrid()
        setupGridView()
        presenter.getList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

//MARK: - Setup view methods -
extension MoviesGridViewController {
    private func setupGridView() {
        moviesGridView.moviesCollectionView.register(cellType: MovieCell.self)
        moviesGridView.moviesCollectionView.delegate = delegate
        moviesGridView.moviesCollectionView.dataSource = dataSource
    }
}

//MARK: - View protocol methods -
extension MoviesGridViewController: MoviesGridViewProtocol {
    
    func reloadRow(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.moviesGridView.moviesCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    func showLoading() {
        moviesGridView.activityIndicator.startAnimating()
        moviesGridView.activityIndicator.isHidden = false
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.moviesGridView.activityIndicator.isHidden = true
            self.moviesGridView.activityIndicator.stopAnimating()
        }
    }
    
    func showMoviesGrid() {
        DispatchQueue.main.async {
            self.moviesGridView.moviesCollectionView.reloadData()
            self.moviesGridView.moviesCollectionView.isHidden = false
        }
    }
    
    func hideMoviesGrid() {
        DispatchQueue.main.async {
            self.moviesGridView.moviesCollectionView.isHidden = true
            self.moviesGridView.layoutIfNeeded()
        }
    }
    
    func reloadMoviesGrid() {
        DispatchQueue.main.async {
            self.moviesGridView.moviesCollectionView.reloadData()
        }
    }
    
    func showError(with errorModel: GenericErrorModel) {
        DispatchQueue.main.async {
            self.moviesGridView.setStateView(with: errorModel)
            self.moviesGridView.genericView.isHidden = false
            self.moviesGridView.layoutIfNeeded()
        }
    }
    
    func hideError() {
        DispatchQueue.main.async {
            self.moviesGridView.genericView.isHidden = true
            self.moviesGridView.layoutIfNeeded()
        }
    }
    
    func pushDetailViewController(with movie: MovieModel) {
        let movieDetail = MovieDetailViewController(with: movie)
        navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func changeDataSourceState(with state: MoviesCollectionViewDataSource.State) {
        dataSource.state = state
    }
}

//MARK: - Search controller methods -
extension MoviesGridViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterSearch(with: searchController.searchBar.text)
    }
}

extension MoviesGridViewController: HomeTabBarChildProtocol {
    
    var searchResultsUpdating: UISearchResultsUpdating? {
        return self
    }
    
}
