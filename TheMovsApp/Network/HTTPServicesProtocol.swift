//
//  HTTPServicesProtocol.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

typealias RequestCallback<T> = (ResultType<T>) -> Void
public typealias HeadersParams = [String : String]

protocol HTTPServicesProtocol {
    func get<T: Decodable>(url: URL, completion: @escaping RequestCallback<T>)
    func cancelTasks()
}

extension HTTPServicesProtocol {
    func cancelTasks() { }
}
