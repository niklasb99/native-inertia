//
//  Item.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 18.05.23.
//

import UIKit
import SwiftUI

/// A simple model to keep track of tasks
class TimeItem: NSObject, ObservableObject, Identifiable {
    var timestamp: Double
    @Published var isChecked: Bool = false

    
    init(time: Double) {
        timestamp = time
    }
}
