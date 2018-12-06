//
//  TMDBConfigurationModel.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

struct TMDBConfigurationModel: Codable {
    
    let baseURL: String
    let backdropSizes: [String]
    let posterSizes: [String]
    
    init(baseURL: String, backdropSizes: [String], posterSizes: [String]) {
        self.baseURL = baseURL
        self.backdropSizes = backdropSizes
        self.posterSizes = posterSizes
    }
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case posterSizes = "poster_sizes"
    }
}
