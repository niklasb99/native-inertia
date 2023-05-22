//
//  DataManager.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 18.05.23.
//

import CoreData
import Foundation

/// Main data manager to handle the timestamp items
class DataManager: NSObject, ObservableObject {
    
    @Published var timeItems = [Double: Bool]()
    fileprivate var managedObjectContext: NSManagedObjectContext
    let container: NSPersistentContainer
    
    override init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading Core Data: \(error)")
            }
        }
        managedObjectContext = container.viewContext
        super.init()
    }
    
    struct TimeItem: Equatable, Identifiable {
        var id = UUID() // Unique identifier
        var isChecked: Bool
        var timestamp: Double
        
        static func ==(lhs: TimeItem, rhs: TimeItem) -> Bool {
            return lhs.isChecked == rhs.isChecked && lhs.timestamp == rhs.timestamp
        }
    }
    
    func fetchData() -> [Double: Bool] {
        let fetchRequest: NSFetchRequest<Testtime> = Testtime.fetchRequest()
        
        do {
            let context = container.viewContext
            let testtimes = try context.fetch(fetchRequest)
            let timestamps: [Double: Bool] = Dictionary(uniqueKeysWithValues: testtimes.map { ($0.timestamp, $0.isChecked) })
            return timestamps
        } catch {
            print("Failed to fetch Testtime objects: \(error)")
        }
        
        return [:]
    }
    
    func fetchTestTimeWithKey(_ key: Double) -> Testtime? {
        let fetchRequest: NSFetchRequest<Testtime> = Testtime.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "timestamp == %@", NSNumber(value: key))
        
        do {
            let context = container.viewContext
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed to fetch Testtime object: \(error)")
        }
        
        return nil
    }
    
    func addTimestamp() {
        let newTimestamp = Testtime(context: container.viewContext)
        newTimestamp.timestamp = (Date().timeIntervalSince1970)*1000
        newTimestamp.isChecked = false
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to add timestamp: \(error)")
        }
    }
    
    func updateBool(for key: Double) {
        // Suche nach dem entsprechenden Core Data-Objekt
        if let testtime = fetchTestTimeWithKey(key) {
            // Aktualisierung der isChecked-Eigenschaft
            testtime.isChecked = !(testtime.isChecked)
            
            // Speichern der Änderungen in Core Data
            do {
                try managedObjectContext.save()
            } catch {
                print("Failed to save changes: \(error)")
            }
        }
    }
    
    func deleteTesttimeWithKey(_ key: Double) {
        if let testtime = fetchTestTimeWithKey(key) {
            container.viewContext.delete(testtime)
            
            do {
                try managedObjectContext.save()
            } catch {
                print("Failed to delete testtime: \(error)")
            }
        }
    }
    
    func deleteAllTimestamps() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Testtime")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
            try managedObjectContext.save()
        } catch {
            print("Failed to delete all timestamps: \(error)")
        }
    }
}
