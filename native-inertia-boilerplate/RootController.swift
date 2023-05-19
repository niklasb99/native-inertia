//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation

class RootController {
    static func index() -> String {
        
        let timestamps: [[Any]] = [[1, true], [2, true], [3, false], [4, true]]

        return Inertia.render(
            component: "Root/Index",
            props: ["timestamps": timestamps],
            url: "/"
        );
    }
    
    
    static func show(id: String) -> String {
        return Inertia.render(
            component: "Root/Show",
            props: ["id": id],
            url: "/"
        );
    }
}
