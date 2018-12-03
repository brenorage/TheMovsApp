//
//  HomeViewController.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 30/11/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

enum HomeTabs: Int, CaseIterable {
    case movies
    
}

class HomeViewController: UITabBarController {
    
    var homeTabs: [HomeTabs]
    
    private lazy var presenter: HomePresenterProtocol = {
        let presenter = HomePresenter(view: self)
        return presenter
    }()
    
    init(tabs: HomeTabs...) {
        homeTabs = tabs
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        fatalError("You must call init(tabs:)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdditionalConfiguration()
    }

}

extension HomeViewController {
    
    private func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
    
}

extension HomeViewController: HomeViewProtocol {
    
    func setTabViewControllers(_ viewControllers: [UIViewController]) {
        setViewControllers(viewControllers, animated: true)
    }
    
}
