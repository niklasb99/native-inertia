//
//  AppRouter.swift
//  ebill
//
//  Created by mbh on 18.02.23.
//

import Foundation
import SwiftyJSON
import WebKit

class AppRouter: InertiaRouter {
    override func setRoutes() {
        
        // index
        self.get("/") { [self] (req) -> String in
            let response = RootController.index()
            delayResponseIfNeeded()
            return response
        }
        
        // show
        self.get("/:id") { [self] (req) -> String in
            let response = RootController.show(id: req.param("id")!)
            delayResponseIfNeeded()
            return response
        }
    }
    
    private func delayResponseIfNeeded() {
        usleep(5000) // Delay in microseconds (8 milliseconds)
    }
}
