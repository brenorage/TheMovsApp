//
//  HomeViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 30/11/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var homeTabs: [TabBarModel]
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var presenter: HomePresenterProtocol = {
        let presenter = HomePresenter(view: self)
        return presenter
    }()
    
    required init(tabs: [TabBarModel]) {
        homeTabs = tabs
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        fatalError("should call init(tbs:)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movs"
        self.delegate = self
        presenter.viewDidLoad()
        initialSetup()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarChanged(with: viewController)
    }
    
}

// MARK: - Functions

extension HomeViewController {
    
    private func initialSetup() {
        view.backgroundColor = .white
        setupTabs()
        setupSearchController()
        tabBarChanged(with: self.selectedViewController)
    }
    
    private func setupTabs() {
        let tabControllers: [UIViewController] = homeTabs.map { tab in
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.icon, selectedImage: tab.icon)
            let viewController = tab.viewController
            viewController.tabBarItem = tabBarItem
            return viewController
        }
        setViewControllers(tabControllers, animated: true)
    }
    
    private func tabBarChanged(with viewController: UIViewController?) {
        if let vc = viewController as? HomeTabBarChildProtocol {
            navigationItem.rightBarButtonItem = vc.rightBarButtonItem
            searchController.searchResultsUpdater = vc.searchResultsUpdating
            searchController.searchBar.text = ""
        }
    }
    
    private func setupSearchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol { }
