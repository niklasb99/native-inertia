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
        self.get("/") { (req) -> String in
            RootController.index()
        }
        
        // show
        self.get("/:id") { (req) -> String in
            RootController.show(id: req.param("id")!)
        }
        
        // add
        self.post("/timestamps") { (req) -> String in
            RootController.add()
        }
        
        // update
        self.patch("/timestamps/:id") { (req) -> String in
            RootController.update(id: req.param("id")!)
        }
        
        // delete
        self.delete("/timestamps/:id") { (req) -> String in
            RootController.delete(id: req.param("id")!)
        }
        
        // delete all
        self.delete("/timestamps") { (req) -> String in
            RootController.deleteAll()
        }
    }
}
