//
//  AppDelegate.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 30/11/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialSetup()
        return true
    }


}

extension AppDelegate {
    
    private func initialSetup() {
        
        
        let initializers: [Initializable] = [ThemeInitializer()]
        initializers.forEach { $0.performInitialization() }
        
        let moviesVC = MoviesGridViewController()
        let moviesTab = TabBarModel(title: "Movies", icon: UIImage(named: "moviesIcon") ?? UIImage(), viewController: moviesVC)
        
        let favoritesVC = FavoviteMovieListViewController()
        let favoriteTab = TabBarModel(title: "Favorites", icon: UIImage(named: "tab-favorites-linear") ?? UIImage(), viewController: favoritesVC)
        
        let homeVC = HomeViewController(tabs: [moviesTab, favoriteTab])
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: homeVC)
        self.window = window
        window.makeKeyAndVisible()
    }
    
}
