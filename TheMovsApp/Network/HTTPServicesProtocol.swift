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
    typealias HeadersParams = [String : String]
    
    init(configuration: URLSessionConfiguration)
    func get<T: Decodable>(url: URL, headers: [HeadersParams]?, completion: @escaping RequestCallback<T>)
    func cancelTasks()
}

extension HTTPServicesProtocol {
    func get<T: Decodable>(url: URL, headers: [HeadersParams]? = nil, completion: @escaping RequestCallback<T>) {
        get(url: url, headers: headers, completion: completion)
    }
}
