//
//  MoviesGridView.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MoviesGridView: UIView {
    
    lazy var moviesCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.accessibilityIdentifier = "Lista de filmes"
        collectionView.accessibilityHint = "Lista os filmes populares do TMDB"
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        return activityIndicator
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviesGridView: CodeView {
    func buildViewHierarchy() {
        addSubview(activityIndicator)
        addSubview(moviesCollectionView)
    }
    
    func setupConstraints() {
        moviesCollectionView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(5)
            maker.bottom.equalToSuperview().offset(5)
            maker.left.equalToSuperview().offset(5)
            maker.right.equalToSuperview().inset(5)
        }
        
        activityIndicator.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.lightYellow
    }
}
