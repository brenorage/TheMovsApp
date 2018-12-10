//
//  MovieDetailPresenterSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 07/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
@testable import TheMovsApp

final class MovieDetailPresenterSpec: XCTestCase {
    
    private var sut: MovieDetailPresenter!
    private var modelStub: MovieModel!
    private var coreDataWorkerStub: CoreDataWorkerStub!
    private var genreClienStub: GenreClientStub!
    private var detailVewController: ViewControllerStub!
    
    override func setUp() {
        
        let bundle = Bundle(for: MovieDetailPresenterSpec.self)
        let url = bundle.url(forResource: "MovieDetail", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        
        modelStub = try! JSONDecoder().decode(MovieModel.self, from: jsonData)
        coreDataWorkerStub = CoreDataWorkerStub()
        genreClienStub = GenreClientStub(httpService: HTTPServices(), coreDataWorker: coreDataWorkerStub)
        
        sut = MovieDetailPresenter(with: modelStub,
                                   coreDataWorker: coreDataWorkerStub,
                                   genreClient: genreClienStub)
        
        detailVewController = ViewControllerStub(with: modelStub)
        detailVewController.presenter = sut
        sut.attachView(detailVewController)
        
    }
    
    func testShouldCallDownloadGenresInCaseTheyAreEmptyInDatabase() {
        let expectation = XCTestExpectation(description: "Test if the list of genres will be downloaded in case they are empty")
        coreDataWorkerStub.shouldReturnEmptyList = true
        sut.viewDidLoad()
        expectation.fulfill()
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGenreInfoShouldBeTreatedInAGoodFormat() {
        let expectation = XCTestExpectation(description: "Test if movie genre will be treated in the correct format with previously saved list of genres")
        coreDataWorkerStub.shouldReturnEmptyList = false
        sut.viewDidLoad()
        expectation.fulfill()
        wait(for: [expectation], timeout: 2.0)
    }
    
}

private final class ViewControllerStub: UIViewController, MovieDetailViewProtocol {
    
    var presenter: MovieDetailPresenterProtocol!
    
    required init(with movie: MovieModel) {
        super.init(nibName: MovieDetailViewController.identifier, bundle: .main)
    }
    
    required init(presenter: MovieDetailPresenterProtocol) {
        super.init(nibName: MovieDetailViewController.identifier, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setScreenTitle(_ title: String) { }
    func setFavoriteMovie(_ isFavorite: Bool) { }
    func fillMovieTitle(with title: String?) { }
    func fillMovieYear(with year: String?) { }
    func fillMovieGenre(with genre: String) {
        XCTAssertEqual("Adventure, Horror", genre)
    }
    func fillMoviePlot(with plot: String?) { }
    func fillMovieBackdrop(with url: URL?) { }
    func setGenreInfoHidden(_ isHidden: Bool) { }
    
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    
    var shouldReturnEmptyList = true
    
    init() { }
    init(context: NSManagedObjectContext) { }
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        if shouldReturnEmptyList {
            completion(.success([]))
        } else {
            let genre1 = GenreMO()
            genre1.name = "Adventure"
            genre1.genreId = Int32(12)
            let genre2 = GenreMO()
            genre2.name = "Horror"
            genre2.genreId = Int32(27)
            completion(.success([genre1, genre2] as! [T]))
        }
    }
    func save() throws { }
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) { }
}

private final class GenreClientStub: GenreClientProtocol {
    
    let httpService: HTTPServicesProtocol
    let coreDataWorkerStub: CoreDataWorkerStub
    var injectedURL = URL(string: "www.google.com.br")!
    
    init(httpService: HTTPServicesProtocol, coreDataWorker: CoreDataWorkerProtocol) {
        self.httpService = httpService
        self.coreDataWorkerStub = coreDataWorker as! CoreDataWorkerStub
    }
    
    func getGenres(completion: @escaping RequestCallback<Bool>) {
        
        httpService.get(url: injectedURL, completion: { (result: ResultType<GenreResponseModel>) in
            XCTAssert(true)
        })
    }
}
