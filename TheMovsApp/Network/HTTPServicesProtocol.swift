//
//  HTTPServicesProtocol.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol HTTPServicesProtocol {
    typealias RequestCallback<T> = (RequestResultType<T>) -> Void
    
    func get<T: Decodable>(url: URL, completion: @escaping RequestCallback<T>)
    func cancelTasks()
}

extension HTTPServicesProtocol {
    func cancelTasks() { }
}
