//
//  FavoriteListTableViewCell.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 12/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var overViewLabel: UILabel!
    
    var model: MovieModel? {
        didSet {
            titleLabel.text = model?.title
            yearLabel.text = model?.releaseYear
            overViewLabel.text = model?.overview
            
            DispatchQueue.main.async {
                self.posterImageView.kf.setImage(with: self.model?.getPosterURL())
            }
            
        }
    }
    
}
