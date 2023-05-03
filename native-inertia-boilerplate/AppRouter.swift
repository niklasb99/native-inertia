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
      IndexController.index()
  }
      
      
  // index
  self.get("/:id") { (req) -> String in
      IndexController.show(id: req.param("id")!)}
  }
}
