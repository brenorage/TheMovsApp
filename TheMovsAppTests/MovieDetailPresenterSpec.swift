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
    private var serviceStub: ServiceStub!
    
    private let bundle = Bundle(for: MovieDetailPresenterSpec.self)
    
    override func setUp() {
        
        let bundle = Bundle(for: MovieDetailPresenterSpec.self)
        let url = bundle.url(forResource: "MovieDetail", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        
        modelStub = try! JSONDecoder().decode(MovieModel.self, from: jsonData)
        coreDataWorkerStub = CoreDataWorkerStub()
        serviceStub = ServiceStub()
        genreClienStub = GenreClientStub(httpService: serviceStub, coreDataWorker: coreDataWorkerStub)
        
        sut = MovieDetailPresenter(with: modelStub,
                                   coreDataWorker: coreDataWorkerStub,
                                   genreClient: genreClienStub)
        
        detailVewController = ViewControllerStub(with: modelStub)
        detailVewController.presenter = sut
        sut.attachView(detailVewController)
        
    }
    
    func testGenreInfoShouldBeTreatedInAGoodFormat() {
        coreDataWorkerStub.shouldReturnEmptyList = false
        sut.viewDidLoad()
        wait(for: 1)
        XCTAssertEqual("Adventure, Horror", detailVewController.genreString)
    }
    
    func testShouldDownloadGenresInCaseTheyAreEmpty() {
        coreDataWorkerStub.shouldReturnEmptyList = true
        sut.viewDidLoad()
        wait(for: 1)
        XCTAssertEqual("Adventure, Horror", detailVewController.genreString)
    }
    
}

private final class ViewControllerStub: UIViewController, MovieDetailViewProtocol {
    
    var genreString: String?
    var presenter: MovieDetailPresenterProtocol!
    
    required init(with movie: MovieModel) {
        super.init(nibName: MovieDetailViewController.identifier, bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setScreenTitle(_ title: String) { }
    func setFavoriteMovie(_ isFavorite: Bool) { }
    func fillMovieTitle(with title: String?) { }
    func fillMovieYear(with year: String?) { }
    func fillMovieGenre(with genre: String?) {
        genreString = genre
    }
    func fillMoviePlot(with plot: String?) { }
    func fillMovieBackdrop(with url: String?) { }
    
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    
    var shouldReturnEmptyList = true
    
    init() { }
    init(persistentContainer: NSPersistentContainer) { }
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
            self.coreDataWorkerStub.shouldReturnEmptyList = false
            completion(.success(true))
        })
    }
}

private final class ServiceStub: HTTPServicesProtocol {
    
    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (ResultType<T>) -> ()) {
        
        let bundle = Bundle(for: ServiceStub.self)
        let url = bundle.url(forResource: "Genres", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode(GenreResponseModel.self, from: jsonData)
        
        let genreResponse = response as! T
        completion(.success(genreResponse))
    }
    
}

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
