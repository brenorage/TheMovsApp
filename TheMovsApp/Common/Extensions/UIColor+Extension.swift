//
//  UIColor+Extension.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 03/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let lightYellow = UIColor(movsColor: .lightYellow)
    static let darkYellow = UIColor(movsColor: .darkYellow)
    static let darkBlue = UIColor(movsColor: .darkBlue)
    
    enum MovsColor: String {
        case lightYellow
        case darkYellow
        case darkBlue
    }
   
    convenience init?(movsColor: MovsColor) {
        self.init(named: movsColor.rawValue)
    }
    
}
