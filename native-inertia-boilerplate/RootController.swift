//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation
import SwiftUI

class RootController {

    static let manager: CompassHeading = CompassHeading()
    
    static func index() -> String {
        print("index wurde aufgerufen")
        
           let data = manager.degrees
          
           
           return Inertia.render(
               component: "Root/Index",
               props: ["degree": data],
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
