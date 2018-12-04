//
//  MoviesListModel.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MoviesListModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages: Int
    
    init(page: Int, results: [MovieModel], totalPages: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
