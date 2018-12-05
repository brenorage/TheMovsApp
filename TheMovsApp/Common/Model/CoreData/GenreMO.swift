//
//  GenreMO.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 05/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

@objc(GenreMO)
public class GenreMO: NSManagedObject {

    @NSManaged public var genreId: Int32
    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?
    
    convenience init() {
        self.init(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
}

// MARK: Generated accessors for movies

extension GenreMO {
    
    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieMO)
    
    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieMO)
    
    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)
    
    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)
    
}
