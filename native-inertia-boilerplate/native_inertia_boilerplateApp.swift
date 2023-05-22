//
//  native_inertia_boilerplateApp.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import SwiftUI

@main
struct native_inertia_boilerplateApp: App {
    @StateObject private var manager: DataManager = DataManager()
    
    // MARK: - Main rendering function
    var body: some Scene {
        WindowGroup {
            let testData = manager.fetchData()
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
