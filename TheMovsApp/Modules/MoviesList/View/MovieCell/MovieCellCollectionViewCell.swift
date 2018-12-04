//
//  MovieCell.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    
    var model: MovieModel? {
        didSet {
            movieTitleLabel.text = model?.title
        }
    }
}
