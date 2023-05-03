//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation

class IndexController {
    static func index() -> String {
        return Inertia.render(
            component: "Index",
            props: [:],
            url: "/"
        );
    }
    
    
    static func show(id: String) -> String {
        return Inertia.render(
            component: "Index",
            props: ["id": id],
            url: "/"
        );
    }
}
