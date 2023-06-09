//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation

class RootController {
    static let manager: LocationManager = LocationManager()

    static func index() -> String {
        return Inertia.render(
            component: "Root/Index",
            props: ["longitude": manager.longitude, "latitude": manager.latitude],
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
