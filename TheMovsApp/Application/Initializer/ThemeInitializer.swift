//
//  ThemeInitializer.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 03/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

final class ThemeInitializer: Initializable {
    
    func performInitialization() {
        tabBarAppearence()
        navigationBarAppearence()
        searchBarAppearence()
    }
    
}

extension ThemeInitializer {
    
    private func tabBarAppearence() {
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().barTintColor = .lightYellow
        UITabBar.appearance().isTranslucent = false
    }
    
    private func navigationBarAppearence() {
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().barTintColor = .lightYellow
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = true
    }
    
    private func searchBarAppearence() {
        UISearchBar.appearance().tintColor = .black
        UISearchBar.appearance().barTintColor = .black
    }

}
