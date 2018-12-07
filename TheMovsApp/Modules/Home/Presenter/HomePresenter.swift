//
//  HomePresenter.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 03/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeViewProtocol?
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
}

