//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//
import CoreData
import SwiftUI

class RootController {
    
    static let manager: DataManager = DataManager()
    
    
    static func index() -> String {
        
        /*let items = manager.fetchData()
        for item in items {
            print(item)
        }*/
        
        // CoreData Fetch Request
        let fetchRequest: NSFetchRequest<Testtime> = Testtime.fetchRequest()
        
        // Core Data Context
        let context = PersistenceManager.shared.persistentContainer.viewContext
        
        do {
            // Fetch Testtime objects from Core Data
            let testtimes = try context.fetch(fetchRequest)
            
            // Convert Testtime objects to desired format (e.g., [[Any]])
            let timestamps: [[Any]] = testtimes.map { [$0.isChecked, $0.timestamp] }
            
            // Render the Inertia response with the fetched data
            return Inertia.render(
                component: "Root/Index",
                props: ["timestamps": timestamps],
                url: "/"
            )
        } catch {
            // Handle any errors that occur during the fetch process
            print("Failed to fetch Testtime objects: \(error)")
            // You can return an error response or handle it in any other appropriate way
            return "Error occurred while fetching data."
        }
    }
    
    
    
    static func show(id: String) -> String {
        return Inertia.render(
            component: "Root/Show",
            props: ["id": Double(id)!],
            url: "/"
        )
    }
    
    static func add() -> String {
        do {
            manager.addTimestamp()
            return Inertia.render(
                component: "Root/Index",
                props: [:],
                url: "/timestamps/add"
            )
        }
    }
    
    static func update(id: String) -> String {
        do {
            manager.updateBool(for: Double(id)!)
            return Inertia.render(
                component: "Root/Index",
                props: ["id": id],
                url: "/timestamps/update/:id"
            )
        }
    }
    
    static func delete(id: String) -> String {
        do {
            manager.deleteTesttimeWithKey(Double(id)!)
            return Inertia.render(
                component: "Root/Index",
                props: ["id": Double(id)!],
                url: "/timestamps/delete/:id"
            )
        }
    }
    
    static func deleteAll() -> String {
        do {
            manager.deleteAllTimestamps()
            
            return Inertia.render(
                component: "Root/Index",
                props: [:],
                url: "/timestamps/delete-all"
            )
        }
    }
    
 
    
    
}
