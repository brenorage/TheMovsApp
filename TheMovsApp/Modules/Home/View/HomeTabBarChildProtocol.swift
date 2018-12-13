//
//  HomeTabBarProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 13/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol HomeTabBarDelegate { }

protocol HomeTabBarChildProtocol {
    var tabBarDelegate: HomeTabBarDelegate { get set }
    var rightBarButtonItem: UIBarButtonItem? { get }
    var searchResultsUpdating: UISearchResultsUpdating? { get }
}

extension HomeTabBarChildProtocol {
    var rightBarButtonItem: UIBarButtonItem? {
        return nil
    }
}
