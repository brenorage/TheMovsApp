//
//  TMDBConfigurationMO.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 06/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import CoreData

@objc(TMDBConfigurationMO)
public class TMDBConfigurationMO: NSManagedObject {
    
    @NSManaged public var baseURL: String
    @NSManaged public var backdropSizes: [String]?
    @NSManaged public var posterSizes: [String]?
    
    convenience init() {
        self.init(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
}
