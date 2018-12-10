//
//  HomePresenter.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 03/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    private weak var view: HomeViewProtocol?
    private let genreClient: GenreClientProtocol
    private let userDefault: UserDefaultWrapperProtocol
    
    required init(view: HomeViewProtocol,
                  genreClient: GenreClientProtocol = GenreClient(),
                  userDefault: UserDefaultWrapperProtocol = UserDefaultWrapper()) {
        
        self.view = view
        self.genreClient = genreClient
        self.userDefault = userDefault
    }
    
    func viewDidLoad() {
        checkSavedGenreList()
    }
    
}

extension HomePresenter {
    
    private func checkSavedGenreList() {
        let downloadedGenres: Bool = userDefault.get(with: UserDefaultWrapper.genresDownloadKey) ?? false
        if !downloadedGenres {
            downloadGenres()
        }
    }
    
    //Faz request para baixar a lista de generos
    private func downloadGenres() {
        genreClient.getGenres() { [weak self] (result: ResultType<Bool>) in
            if case .success(_) = result {
                debugPrint("HomePresenter: downloadGenres success")
                self?.userDefault.save(object: true, with: UserDefaultWrapper.genresDownloadKey)
            } else {
                self?.userDefault.save(object: false, with: UserDefaultWrapper.genresDownloadKey)
                debugPrint("HomePresenter: downloadGenres fail")
            }
        }
    }
    
}
