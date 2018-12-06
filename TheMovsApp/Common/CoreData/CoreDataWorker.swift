//
//  CoreDataWorkerProtocol.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 05/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

protocol CoreDataWorkerProtocol {
    typealias CompletionCallback<T> = (ResultType<T>) -> Void
    func fetchAll<T: NSManagedObject>(completion: @escaping CompletionCallback<[T]>)
    func save() throws
    func delete(enity: NSManagedObject)
}

class CoreDataWorker: CoreDataWorkerProtocol {
    
    func fetchAll<T>(completion: @escaping (ResultType<[T]>) -> Void) where T : NSManagedObject {
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
