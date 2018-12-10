//
//  HomePresenterSpec.swift
//  TheMovsAppTests
//
//  Created by andre.luiz.de.souza on 10/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import XCTest
import CoreData
@testable import TheMovsApp

final class HomePresenterSpec: XCTestCase {
    
    private var sut: HomePresenter!
    private var userDefaultStub: UserDefaultStub!
    private var homeViewControllerStub: HomeViewControllerStub!
    
    override func setUp() {
        homeViewControllerStub = HomeViewControllerStub(tabs: [])
        userDefaultStub = UserDefaultStub()
        let genreClient = GenreClient.init(httpService: ServiceStub(), coreDataWorker: CoreDataWorkerStub())
        sut = HomePresenter(view: homeViewControllerStub, genreClient: genreClient, userDefault: userDefaultStub)
        homeViewControllerStub.presenter = sut
    }
    
    func testPresenterShouldDownloadGenresOnViewDidLoadIfTheyAreNotSavedYet() {
        let expectation = XCTestExpectation(description: "Test if presenter will download the genre on view did load")
        homeViewControllerStub.viewDidLoad()
        expectation.fulfill()
        wait(for: [expectation], timeout: 2.0)
    }
    
}


private final class HomeViewControllerStub: UIViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol!
    
    init(tabs: [TabBarModel]) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

private final class UserDefaultStub: UserDefaultWrapperProtocol {
    func saveJSON<T>(object: T, with key: String) where T : Encodable { }
    
    func getObjectFromJSON<T>(with key: String) -> T? where T : Decodable {
        return nil
    }
    
    func get<T>(with key: String) -> T? {
        return false as? T
    }
    
    func save<T>(object: T, with key: String) { }
    
    func deleteItem<T: Equatable>(in index: Int, with key: String) -> [T]? {
        return []
    }
}


private final class ServiceStub: HTTPServicesProtocol {
    
    var injectedURL: URL!
    
    func get<T: Decodable>(url: URL, completion: @escaping (ResultType<T>) -> ()) {
        
        let bundle = Bundle(for: GenreClientSpec.self)
        let url = bundle.url(forResource: "Genres", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        let response = try! JSONDecoder().decode(GenreResponseModel.self, from: jsonData)
        
        let genreResponse = response as! T
        completion(.success(genreResponse))
        
        XCTAssertTrue(true)
    }
    
}

private final class CoreDataWorkerStub: CoreDataWorkerProtocol {
    init() { }
    init(context: NSManagedObjectContext) { }
    func fetchAll<T>(completion: @escaping (ResultType<Array<T>>) -> ()) where T : NSManagedObject { }
    func save() throws {
    }
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> ()) { }
}
