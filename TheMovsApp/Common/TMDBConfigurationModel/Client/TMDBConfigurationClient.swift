//
//  TMDBConfigurationClient.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

protocol TMDBConfigurationClientProtocol {
    init(httpService: HTTPServicesProtocol, userDefault: UserDefaultWrapperProtocol)
}

class TMDBConfigurationClient: TMDBConfigurationClientProtocol {
    
    fileprivate var httpService: HTTPServicesProtocol
    fileprivate var userDefault: UserDefaultWrapperProtocol
    
    required init(httpService: HTTPServicesProtocol = HTTPServices(), userDefault: UserDefaultWrapperProtocol = UserDefaultWrapper()) {
        self.httpService = httpService
        self.userDefault = userDefault
    }
}

extension TMDBConfigurationClient {
    func getConfigurationModel(completion: ((ResultType<Bool>) -> Void)?) {
        guard let url = TMDBEndpoint.configuration.endpoint else {
            completion?(.failure)
            return
        }
        
        httpService.get(url: url) { [weak self] (result: ResultType<TMDBConfigurationModelResponse>) in
            switch result {
            case let .success(configModel):
                self?.userDefault.saveJSON(object: configModel.images, with: UserDefaultWrapper.configModelKey)
                completion?(.success(true))
            case .failure:
                completion?(.failure)
            }
        }
    }
}
