//
//  TMDBUrl.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 04/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

struct TMDBUrl {
    private let apiBaseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    
    private var currentLanguage: String {
        return Locale.current.identifier
    }
    
    func getAPIURL(route: String) -> URLComponents? {
        guard var url = URL(string: apiBaseURL) else { return nil }
        url.appendPathComponent(route)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let apiKeyQueryItem = URLQueryItem.init(name: "api_key", value: apiKey)
        let languageQueryItem = URLQueryItem.init(name: "language", value: currentLanguage)
        urlComponents?.queryItems = [apiKeyQueryItem, languageQueryItem]
        return urlComponents
    }
}


enum TMDBEndpoint {
    
    case popularMovies(page: Int)
    
    var endpoint: URL? {
        switch self {
        case let .popularMovies(page):
            let tmdbURL = TMDBUrl()
            var urlComponents = tmdbURL.getAPIURL(route: self.rawValue)
            let pageQueryItem = URLQueryItem.init(name: "", value: String(page))
            urlComponents?.queryItems?.append(pageQueryItem)
            return urlComponents?.url
        }
    }
    
    var rawValue: String {
        switch self {
        case .popularMovies(_):
            return "movie/popular"
        }
    }
}
