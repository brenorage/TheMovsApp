//
//  MovieCell.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var favoriteImageView: UIImageView!
    
    static let cellSize = CGSize(width: 150, height: 260)
    
    var model: MovieModel? {
        didSet {
            movieTitleLabel.text = model?.title
            if let isFavorite = model?.isFavorite, isFavorite {
                favoriteImageView.image = UIImage(named: "favorite-yellow")
            } else {
                favoriteImageView.image = UIImage(named: "favorite-gray")
            }
            DispatchQueue.main.async {
                self.imageView.kf.setImage(with: self.model?.getPosterURL())
            }
        }
    }
}
