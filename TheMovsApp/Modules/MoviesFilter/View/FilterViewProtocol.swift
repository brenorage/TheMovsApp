//
//  FilterViewProtocol.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 13/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

protocol FilterTypeViewProtocol: class {
    func openVC(with vc: UIViewController)
    func fillFilterParams(with key: String, and value: String)
    func removeFilterParam(with key: String)
}

extension FilterTypeViewProtocol {
    func openVC(with vc: UIViewController) { }
    func fillFilterParams(with key: String, and value: String) { }
    func removeFilterParam(with key: String) { } 
}
