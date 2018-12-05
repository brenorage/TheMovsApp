//
//  DescribeProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 05/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol DescribeProtocol: class { }

extension DescribeProtocol where Self: NSObject {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
