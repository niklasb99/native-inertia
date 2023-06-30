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
            delay()
            return response
        }
        
        // show
        self.get("/:id") { [self] (req) -> String in
            let response = RootController.show(id: req.param("id")!)
            delay()
            return response
        }
    }
    
    private func delay() {
        usleep(5000)
    }
}
