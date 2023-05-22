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
        self.delete("/timestamps/add") { (req) -> String in
            RootController.add()
        }
        
        // update
        self.delete("/timestamps/update/:id") { (req) -> String in
            RootController.update(id: req.param("id")!)
        }
        
        // delete
        self.delete("/timestamps/delete/:id") { (req) -> String in
            RootController.delete(id: req.param("id")!)
        }
        
        // delete all
        self.delete("/timestamps/delete-all") { (req) -> String in
            RootController.deleteAll()
        }
        
        
    }
}
