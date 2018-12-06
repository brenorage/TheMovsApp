//
//  GenreClient.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 06/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol GenreClientProtocol {
    typealias RequestCallback = (ResultType<Bool>) -> Void
    init(httpService: HTTPServicesProtocol, coreDataWorker: CoreDataWorkerProtocol)
    func getGenres(completion: @escaping RequestCallback)
}

class GenreClient: GenreClientProtocol {

    private let httpService: HTTPServicesProtocol
    private let coreDataWorker: CoreDataWorkerProtocol
    
    required init(httpService: HTTPServicesProtocol = HTTPServices(),
                  coreDataWorker: CoreDataWorkerProtocol = CoreDataWorker()) {
        self.httpService = httpService
        self.coreDataWorker = coreDataWorker
    }
    
}

extension GenreClient {
    
    func getGenres(completion: @escaping RequestCallback<Bool>) {
        
        guard let url = TMDBEndpoint.genreList.endpoint else {
            return completion(.failure)
        }
        
        httpService.get(url: url, completion: { [weak self] (result: ResultType<GenreResponseModel>) in
            switch result {
            case .success(let response):
                _ = response.genres.compactMap({ self?.createGenreMO($0) })
                do {
                    try self?.coreDataWorker.save()
                    completion(.success(true))
                } catch {
                    completion(.failure)
                }
            case .failure:
                completion(.failure)
            }
        })
    }
    
}


extension GenreClient {

    private func createGenreMO(_ genre: GenreModel) -> GenreMO? {
        guard
            let genreId = genre.genreId,
            let name = genre.name
        else { return nil }
        
        let genreMO = GenreMO()
        genreMO.name = name
        genreMO.genreId = Int32(genreId)
        
        return genreMO
    }

}
