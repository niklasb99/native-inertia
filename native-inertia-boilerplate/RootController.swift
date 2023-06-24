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
        let data = manager.fetchData()
        var timestamps: [[Any]] = []

        for (key, value) in data {
            let item: [Any] = [value, key]
            timestamps.append(item)
        }
        
        print("data", data)
        print("timestamps", timestamps)

        
        
        return Inertia.render(
            component: "Root/Index",
            props: ["timestamps": timestamps],
            url: "/"
        )
    }
    
    
    static func show(id: String) -> String {
        return RootController.index()
    }
    
    static func add() -> String {
        do {
            manager.addTimestamp()
            return RootController.index()
        }
    }
    
    static func update(id: String) -> String {
        do {
            manager.updateBool(for: Double(id)!)
            
            return RootController.index()
        }
    }
    
    static func delete(id: String) -> String {
        do {
            manager.deleteTesttimeWithKey(Double(id)!)
            
            return RootController.index()
        }
    }
    
    static func deleteAll() -> String {
        do {
            manager.deleteAllTimestamps()
            
            
            return RootController.index()
        }
    }
    
 
    
    
}
