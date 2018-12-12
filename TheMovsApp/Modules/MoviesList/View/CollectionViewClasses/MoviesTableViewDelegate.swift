//
//  MoviesCollectionViewDelegate.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesCollectionViewDelegate: NSObject {
    private let collectionViewPadding: CGFloat = 10
    private var presenter: MoviesGridPresenterProtocol
    
    init(presenter: MoviesGridPresenterProtocol) {
        self.presenter = presenter
    }
}

extension MoviesCollectionViewDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width/2 - (2*collectionViewPadding)
        let heightMultiplier = width / MovieCell.cellSize.width
        let height = MovieCell.cellSize.height * heightMultiplier
        
        return CGSize(width: width, height: height)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        let seventyPercent = scrollView.contentSize.height * 0.7
        if scrollPosition >= seventyPercent {
            presenter.getMoreMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = presenter.moviesPages[indexPath.section][indexPath.item]
        presenter.viewProtocol?.pushDetailViewController(with: model)
    }
    
}
