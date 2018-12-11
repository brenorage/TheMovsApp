//
//  MoviesCollectionViewDataSource.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesCollectionViewDataSource: NSObject {
    
    enum State { case normal, search }
    
    var state: State = .normal
    
    private var presenter: MoviesGridPresenterProtocol
    
    init(presenter: MoviesGridPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MoviesCollectionViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch state {
        case .normal:
            return presenter.moviesPages.count
        case .search:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .normal:
            return presenter.moviesPages[section].count
        case .search:
            return presenter.filteredMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = getModel(for: indexPath)
        let cell = collectionView.dequeueReusableCell(MovieCell.self, for: indexPath)
        cell.model = model
        return cell
    }
    
    private func getModel(for indexPath: IndexPath) -> MovieModel {
        switch state {
        case .normal:
            return presenter.moviesPages[indexPath.section][indexPath.item]
        case .search:
            return presenter.filteredMovies[indexPath.item]
        }
    }
}
