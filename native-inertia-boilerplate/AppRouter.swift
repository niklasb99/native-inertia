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
    let imageManager = ImageManager()
    
    override func setRoutes() {
        self.get("/") { (req) -> String in
            RootController.index()
        }
        
        self.delete("/:id") { (req) -> String in
            print("AppRouter - delete")
            return RootController.delete(id: req.param("id")!)
        }
        
        self.get("/takePicture") { (req) -> String in
            RootController.takePicture(imageManager: self.imageManager)
        }
        
    }
}
