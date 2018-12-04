//
//  MoviesCollectionViewDataSource.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesCollectionViewDataSource: NSObject {
    private var presenter: MoviesListPresenterProtocol
    
    init(presenter: MoviesListPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MoviesCollectionViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.moviesPages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.moviesPages[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = presenter.moviesPages[indexPath.section][indexPath.item]
        let cell = collectionView.dequeueReusableCell(MovieCell.self, for: indexPath)
        cell.model = model
        return cell
    }
}
