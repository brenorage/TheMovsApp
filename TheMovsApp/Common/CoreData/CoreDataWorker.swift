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
    func delete(enity: NSManagedObject, completion: @escaping CompletionCallback<Bool>)
    init(context: NSManagedObjectContext)
    init()
}


final class CoreDataWorker: CoreDataWorkerProtocol {
    
    private let context: NSManagedObjectContext
    
    convenience init() {
        self.init(context: CoreDataManager.shared.persistentContainer.newBackgroundContext())
    }
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAll<T>(completion: @escaping (ResultType<[T]>) -> Void) where T : NSManagedObject {
        let fetchRequest = NSFetchRequest<T>(entityName: T.identifier)
        context.performAndWait {
            do {
                let array = try context.fetch(fetchRequest) as [T]
                completion(.success(array))
            } catch let error {
                print("error FetchRequest \(error)")
                completion(.failure)
            }
        }
    }
    
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func delete(enity: NSManagedObject, completion: @escaping (ResultType<Bool>) -> Void) {
        context.performAndWait {
            context.delete(enity)
            completion(.success(true))
        }
    }

}
