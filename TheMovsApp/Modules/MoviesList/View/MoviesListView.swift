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
        let collectionView = UICollectionView()
        return collectionView
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
        addSubview(moviesCollectionView)
    }
    
    func setupConstraints() {
        moviesCollectionView.snp.makeConstraints { maker in
            maker.top.bottom.right.left.equalToSuperview()
        }
    }
}
