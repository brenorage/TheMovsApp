//
//  CoreDataManager.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 04/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

//MARK: - CoreDataManager

final class CoreDataManager: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovsDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static let shared = CoreDataManager()
    
    private override init() {
        debugPrint("CoreDataManager initialized")
    }
    
}
