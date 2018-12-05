//
//  CoreDataWorkerProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 05/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

protocol CoreDataWorkerProtocol {
    func fetchAll<T: NSManagedObject>(of: T.Type, completion: @escaping (ResultType<[T]>) -> Void)
    func save() throws
    func delete(enity: NSManagedObject)
}

class CoreDataWorker: CoreDataWorkerProtocol {
    
    func fetchAll<T: NSManagedObject>(of: T.Type, completion: @escaping (ResultType<[T]>) -> Void) {
        let fetchRequest = NSFetchRequest<T>(entityName: T.identifier)
        CoreDataManager.shared.persistentContainer.performBackgroundTask ({ (context) in
            do {
                let array = try context.fetch(fetchRequest) as [T]
                completion(.success(array))
            } catch let error {
                print("error FetchRequest \(error)")
                completion(.failure)
            }
        })
    }
    
    
    func save() throws {
        try CoreDataManager.shared.persistentContainer.viewContext.save()
    }
    
    func delete(enity: NSManagedObject) {
        CoreDataManager.shared.persistentContainer.performBackgroundTask ({ (context) in
            context.delete(enity)
        })
    }

}
