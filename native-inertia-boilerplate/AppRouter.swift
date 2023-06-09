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
        // index
        self.get("/") { (req) -> String in
            RootController.index()
        }
        
        // show
       /* self.get("/:id") { (req) -> String in
            RootController.show(id: req.param("id")!)
        }*/
        
        // take picture
        self.get("/takePicture") { (req) -> String in
            RootController.takePicture(imageManager: self.imageManager)
        }
        
        /*self.get("/getImages") { (req) -> String in
            RootController.getImages()
        }*/
    }
}
