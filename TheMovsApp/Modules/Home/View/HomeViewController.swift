//
//  HomeViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 30/11/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    private var homeTabs: [TabBarModel]
    
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
        presenter.viewDidLoad()
        setupAdditionalConfiguration()
    }

}

// MARK: - Functions

extension HomeViewController {
    
    private func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        setupTabs()
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
    
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol { }
