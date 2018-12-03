//
//  MovieModel.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieModel: Codable {
    
    let title: String
    let overview: String
    private let releaseDate: String
    let posterPath: String
    let genreIds: [Int]

    var releaseYear: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self.releaseDate) else { return nil }
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    init(title: String, overview: String, releaseDate: String, posterPath: String, genreIds: [Int]) {
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.genreIds = genreIds
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
    
}
