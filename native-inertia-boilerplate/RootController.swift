//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation

class RootController {
    
    
    static func index() -> String {
        return Inertia.render(
            component: "Root/Index",
            props: ["time": ISO8601DateFormatter().string(from: Date())],
            url: "/"
        );
    }
    
    static func show(id: String, color: String) -> String {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter
        }
        
        return Inertia.render(
            component: "Root/Show",
            props: ["id": id, "time": dateFormatter.string(from: Date()), "color": color],
            url: "/"
        );
    }
}
