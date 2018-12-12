//
//  MovieModel.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 03/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieModel: Codable {
    
    let movieId: Int?
    let title: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]?
    var userDefaultWrapper: UserDefaultWrapperProtocol = UserDefaultWrapper()
    var isFavorite: Bool = false
    var cachedGenres: [GenreMO] = []
    
    var releaseYear: String? {
        guard let releaseDate = self.releaseDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return nil }
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    init(movieId: Int?, title: String?, overview: String?, releaseDate: String?, posterPath: String?,
         backdropPath: String?, genreIds: [Int]? = nil, isFavorite: Bool = false) {

        self.movieId = movieId
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.isFavorite = isFavorite
        
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case movieId = "id"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
}

extension MovieModel {
    func getPosterURL() -> URL? {
        guard let posterPath = self.posterPath else { return nil }
        let configModel: TMDBConfigurationModel? = userDefaultWrapper.getObjectFromJSON(with: UserDefaultWrapper.configModelKey)
        guard let baseURL = configModel?.baseURL else { return nil }
        var url = URL(string: baseURL)
        url?.appendPathComponent("w185")
        url?.appendPathComponent(posterPath)
        return url
    }
    
    func getBackdropURL() -> URL? {
        guard let backdropPath = self.backdropPath else { return nil }
        let configModel: TMDBConfigurationModel? = userDefaultWrapper.getObjectFromJSON(with: UserDefaultWrapper.configModelKey)
        guard let baseURL = configModel?.baseURL else { return nil }
        var url = URL(string: baseURL)
        url?.appendPathComponent("w500")
        url?.appendPathComponent(backdropPath)
        return url
    }
    
    
}
