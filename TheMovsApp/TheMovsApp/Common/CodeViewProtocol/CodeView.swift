//
//  CodeView.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 30/11/18.
//  Copyright © 2018 andre.luiz.de.souza. All rights reserved.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
    
}
