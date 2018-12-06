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
    var coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker()
    
    var releaseYear: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self.releaseDate) else { return nil }
        let year = Calendar.current.component(.year, from: date)
        return "\(year)"
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
    }
}

extension MovieModel {
    func getPosterURL(completion: @escaping (URL?) -> Void){
        coreDataWorker.fetchAll { (result: ResultType<[TMDBConfigurationMO]>) in
            switch result {
            case let .success(data):
                guard let configModelMO = data.first else { return completion(nil) }
                let baseURL = configModelMO.baseURL
                var url = URL(string: baseURL)
                url?.appendPathComponent("original")
                url?.appendPathComponent(self.posterPath)
                completion(url)
            case .failure:
                completion(nil)
            }
        }
    }
}
