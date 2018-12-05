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
    private let delegate = MoviesCollectionViewDelegate()
    
    private var dataSource: MoviesCollectionViewDataSource
    private var presenter: MoviesListPresenterProtocol
    
    init(presenter: MoviesListPresenterProtocol = MoviesListPresenter()) {
        self.presenter = presenter
        dataSource = MoviesCollectionViewDataSource(presenter: presenter)
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
        moviesGridView.moviesCollectionView.isHidden = true
    }
    
    func reloadMoviesGrid(with sectionIndex: Int) {
        let indexSet = IndexSet(integer: sectionIndex)
        moviesGridView.moviesCollectionView.reloadSections(indexSet)
    }
}
