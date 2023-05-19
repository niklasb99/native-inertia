//
//  ShowTimestamps.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 19.05.23.
//

import SwiftUI
import CoreData

struct TimestampView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var timeItems: FetchedResults<Testtime>
    
    var body: some View {
        let timestamps = timeItems.map { item in
            return [
                "timestamp": item.timestamp,
                "isChecked": item.isChecked
            ]
        }
        
    }
}
