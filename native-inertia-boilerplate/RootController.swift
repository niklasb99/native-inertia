//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation

class RootController {
    static let manager: CompassHeading = CompassHeading()
    static var lastResponseTime: TimeInterval = 0

    static func index() -> String {
        let data = manager.degrees
        
        let currentTime = Date().timeIntervalSince1970
        let timeDiff = currentTime - lastResponseTime
        
        if timeDiff < 0.005 {
            usleep(useconds_t(5000 - Int(timeDiff * 1000000)))
        }

        lastResponseTime = Date().timeIntervalSince1970

        return Inertia.render(
            component: "Root/Index",
            props: [
                        "degree": data
                   ],
            url: "/"
        );
    }
    
    
    static func show(id: String) -> String {
        let currentTime = Date().timeIntervalSince1970
        let timeDiff = currentTime - lastResponseTime
        
        if timeDiff < 0.005 {
            usleep(useconds_t(5000 - Int(timeDiff * 1000000)))
        }
        
        lastResponseTime = Date().timeIntervalSince1970

        return Inertia.render(
            component: "Root/Show",
            props: ["id": id],
            url: "/"
        );
    }
}
