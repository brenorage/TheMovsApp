//
//  MoviesGridViewController.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesGridViewController: UIViewController, MoviesGridViewProtocol {
    
    private let moviesGridView = MoviesGridView()
    private let delegate = MoviesCollectionViewDelegate()
    
    private lazy var dataSource = MoviesCollectionViewDataSource(presenter: presenter)
    private lazy var presenter: MoviesListPresenterProtocol = MoviesListPresenter(viewProtocol: self)
    
    override func loadView() {
        self.view = moviesGridView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

//MARK: - Setup view methods -
extension MoviesGridViewController {
    private func setupTableView() {
        moviesGridView.moviesCollectionView.register(cellType: MovieCell.self)
        moviesGridView.moviesCollectionView.delegate = delegate
        moviesGridView.moviesCollectionView.dataSource = dataSource
    }
}
