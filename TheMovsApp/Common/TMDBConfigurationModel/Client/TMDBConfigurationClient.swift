//
//  TMDBConfigurationClient.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol TMDBConfigurationClientProtocol {
    init(httpService: HTTPServicesProtocol)
}

class TMDBConfigurationClient: TMDBConfigurationClientProtocol {
    
    fileprivate var httpService: HTTPServicesProtocol
    
    required init(httpService: HTTPServicesProtocol = HTTPServices()) {
        self.httpService = httpService
    }
}

extension TMDBConfigurationClient {
    func getConfigurationModel(completion: @escaping (ResultType<Bool>) -> Void) {
        guard let url = TMDBEndpoint.configuration.endpoint else { return completion(.failure) }
        
        httpService.get(url: url) { [weak self] (result: ResultType<TMDBConfigurationModel>) in
            switch result {
            case let .success(configModel):
                _ = self?.mountTMDBMO(with: configModel)
                do {
                    let worker = CoreDataWorker()
                    try worker.save()
                    completion(.success(true))
                } catch {
                    completion(.success(false))
                }
            case .failure:
                completion(.failure)
            }
        }
    }
    
    private func mountTMDBMO(with configModel: TMDBConfigurationModel) -> TMDBConfigurationMO {
        let coreDataModel = TMDBConfigurationMO()
        coreDataModel.baseURL = configModel.baseURL
        coreDataModel.backdropSizes = configModel.backdropSizes
        coreDataModel.posterSizes = configModel.posterSizes
        return coreDataModel
    }
}
