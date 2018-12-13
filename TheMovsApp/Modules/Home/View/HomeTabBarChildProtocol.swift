//
//  HomeTabBarProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 13/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol HomeTabBarChildProtocol {
    var rightBarButtonItem: UIBarButtonItem? { get }
    var searchResultsUpdating: UISearchResultsUpdating? { get }
}

extension HomeTabBarChildProtocol {
    var rightBarButtonItem: UIBarButtonItem? {
        return nil
    }
}
