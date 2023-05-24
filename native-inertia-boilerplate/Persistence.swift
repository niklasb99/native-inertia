//
//  Persistence.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import CoreData

class PersistenceManager {
    static let shared = PersistenceManager()
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Failed to load Core Data stack: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private init() {}
}
