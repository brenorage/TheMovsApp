//
//  CoreDataManager.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 04/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

//MARK: - Core Data stack

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

// MARK: - Core Data Saving support

extension CoreDataManager {
    
    func saveContext() throws {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
        }
    }
    
}
