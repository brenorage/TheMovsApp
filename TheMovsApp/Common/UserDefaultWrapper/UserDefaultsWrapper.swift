//
//  UserDefaultsWrapper.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol UserDefaultWrapperProtocol {
    
    func get<T>(with key: String) -> T?
    func save<T>(object: T, with key: String)
    func deleteItem<T: Equatable>(in index: Int, with key: String) -> [T]?
    func saveJSON<T: Encodable>(object: T, with key: String)
    func getObjectFromJSON<T: Decodable>(with key: String) -> T?
}

class UserDefaultWrapper: UserDefaultWrapperProtocol {
    static let tmdbFavsKey = "TMDBFavsKey"
    static let configModelKey = "ConfigModelKey"
    
    private let defaults = UserDefaults.standard
    
    func get<T>(with key: String) -> T? {
        let data = defaults.object(forKey: key)
        if let unwrappedData = data as? T {
            return unwrappedData
        } else {
            return nil
        }
    }
    
    func save<T>(object: T, with key: String) {
        defaults.set(object, forKey: key)
    }
    
    func deleteItem<T: Equatable>(in index: Int, with key: String) -> [T]? {
        guard let result: [T] = get(with: key) else { return nil }
        var recoveryArray = result
        recoveryArray.remove(at: index)
        defaults.set(recoveryArray, forKey: key)
        return recoveryArray
    }
    
    func saveJSON<T: Encodable>(object: T, with key: String) {
        guard let json = try? JSONEncoder().encode(object) else { return }
        save(object: json, with: key)
    }
    
    func getObjectFromJSON<T: Decodable>(with key: String) -> T? {
        guard
            let data: Data? = get(with: key),
            let json = data,
            let object = try? JSONDecoder().decode(T.self, from: json)
        else { return nil }
        return object
    }
}
