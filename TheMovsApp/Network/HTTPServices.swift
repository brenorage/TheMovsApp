//
//  HTTPServices.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 30/11/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class HTTPServices {

    private let urlSession: URLSession?
    private var dataTask: URLSessionDataTask?

    required init(configuration: URLSessionConfiguration = .default) {
        urlSession = URLSession(configuration: configuration)
    }
    
}

extension HTTPServices: HTTPServicesProtocol {
    func get<T : Decodable>(url: URL, completion: @escaping RequestCallback<T>) {
        cancelTasks()
        
        dataTask = urlSession?.dataTask(with: url) { data, urlResponse, error in
            
            if error != nil {
                completion(.failure)
            }   else if let data = data,
                let response = urlResponse as? HTTPURLResponse,
                Array(200..<300).contains(response.statusCode) {
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                }
                catch {
                    completion(.failure)
                }
            }
        }
        
        dataTask?.resume()
    }
    
    func cancelTasks() {
        dataTask?.cancel()
    }
}
