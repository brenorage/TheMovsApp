//
//  GenericErrorModel.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 07/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

struct GenericErrorModel {
    let imageName: String
    let imageColor: UIColor
    let message: String
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}
