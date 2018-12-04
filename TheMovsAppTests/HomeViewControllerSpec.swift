//
//  HomeViewControllerSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 04/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
@testable import TheMovsApp

class HomeViewControllerSpec: XCTestCase {
    
    func testCustomInitWithTabBarModelShouldAddViewControllers() {
        
        let tabs: [TabBarModel] = [TabBarModel(title: "Tab 1", icon: UIImage(), viewController: UIViewController()),
                                   TabBarModel(title: "Tab 2", icon: UIImage(), viewController: UIViewController())]
        
        let homeViewController = HomeViewController(tabs: tabs)
        XCTAssertEqual(homeViewController.viewControllers!.count, 2)
    }


}
