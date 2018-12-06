//
//  MovieMO.swift
//  TheMovsApp
//
//  Created by andre.luiz.de.souza on 05/12/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

@objc(MovieMO)
public class MovieMO: NSManagedObject {
    
    @NSManaged public var movieId: Int32
    @NSManaged public var overview: String?
    @NSManaged public var poster: Data?
    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var genres: NSSet?
    
    convenience init() {
        self.init(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
}


// MARK: Generated accessors for genres

extension MovieMO {
    
    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreMO)
    
    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreMO)
    
    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)
    
    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)
    
}
