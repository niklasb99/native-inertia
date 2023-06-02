//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation
import SwiftUI

class RootController {
    
    static let manager: LocationManager = LocationManager()
    
    static func index() -> String {
        let gpsDict: [String: Any] = [
            "longitude": manager.longitude,
            "latitude": manager.latitude
        ]
        
        return Inertia.render(
            component: "Root/Index",
            props: ["gps": gpsDict],
            url: "/"
        )
    }
    
    static func show(id: String) -> String {
        return Inertia.render(
            component: "Root/Show",
            props: ["id": id],
            url: "/"
        );
    }
}
