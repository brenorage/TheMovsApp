//
//  ResultType.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 30/11/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

enum ResultType<T> {
    case success(T)
    case failure
}
