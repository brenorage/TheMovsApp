//
//  GenreModel.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 06/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

struct GenreModel: Codable {
    
    let genreId: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name    = "name"
    }
    
}
