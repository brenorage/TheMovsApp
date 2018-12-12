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
    
    func testGenreClientShouldDownloadGenresInCaseTheyAreEmptyInDatabase() {
        let expectation = XCTestExpectation(description: "Test if the list of genres will be downloaded in case they are empty")
        genreClienStub.expectation = expectation
        coreDataWorkerStub.shouldReturnEmptyList = true
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(genreClienStub.didCallGetGenres)
    }
    
    func testGenreInfoShouldBeTreatedInAGoodFormat() {
        let expectation = XCTestExpectation(description: "Test if movie genre will be treated in the correct format with previously saved list of genres")
        detailVewController.expectation = expectation
        coreDataWorkerStub.shouldReturnEmptyList = false
        sut.viewDidLoad()
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual("Adventure, Horror", detailVewController.treatedGenre)
    }
    
    func testFetchGenresShouldNotBeCalledIfMovieModelHasACacheOfSavedGenres() {
        let expectation = XCTestExpectation(description: "Test if presenter will fetch saved genres in case they are already set in the movie model cache")
        coreDataWorkerStub.expectation = expectation
        modelStub.cachedGenres = [GenreMO(), GenreMO()]
        sut.viewDidLoad()
        XCTAssertFalse(coreDataWorkerStub.didCallFetchAll)
    }
    

    func testFavoriteMovieShouldBeDeletedOnTouchFavoriteFunction() {
        let expectation = XCTestExpectation(description: "Test if the favorited movie will be deleted after call didTouchFavorite() funcion")
        coreDataWorkerStub.expectation = expectation
        modelStub.isFavorite = true
        sut.didTouchFavoriteMovie()
        XCTAssertTrue(coreDataWorkerStub.didDelete)
    }
    
}

private final class ViewControllerStub: UIViewController, MovieDetailViewProtocol {
    
    var presenter: MovieDetailPresenterProtocol!
    var expectation: XCTestExpectation?
    var treatedGenre: String?
    var favoriteDelegate: FavoriteMovieDelegate?
    
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
        treatedGenre = genre
        expectation?.fulfill()
    }
    func fillMoviePlot(with plot: String?) { }
    func fillMovieBackdrop(with url: URL?) { }
    func setGenreInfoHidden(_ isHidden: Bool) { }
    func setFavorite(_ isFavorite: Bool) { }
    
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    
    var shouldReturnEmptyList = true
    var didCallFetchAll = false
    var didSave = false
    var didDelete = false
    var expectation: XCTestExpectation?
    
    init() { }
    init(context: NSManagedObjectContext) { }
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        didCallFetchAll = true
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
        
        expectation?.fulfill()
    }
    func fetch<T>(with predicate: NSPredicate, completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject {
        completion(.success([MovieMO()] as! [T]))
    }
    func save() throws {
        didSave = true
        expectation?.fulfill()
    }
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) {
        didDelete = true
        expectation?.fulfill()
    }
}

private final class GenreClientStub: GenreClientProtocol {
    
    let httpService: HTTPServicesProtocol
    let coreDataWorkerStub: CoreDataWorkerStub
    var injectedURL = URL(string: "www.google.com.br")!
    
    var didCallGetGenres = false
    var expectation: XCTestExpectation?
    
    init(httpService: HTTPServicesProtocol, coreDataWorker: CoreDataWorkerProtocol) {
        self.httpService = httpService
        self.coreDataWorkerStub = coreDataWorker as! CoreDataWorkerStub
    }
    
    func getGenres(completion: @escaping RequestCallback<Bool>) {
        
        httpService.get(url: injectedURL, completion: { (result: ResultType<GenreResponseModel>) in
            self.didCallGetGenres = true
            self.expectation?.fulfill()
        })
    }
}
