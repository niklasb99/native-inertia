//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

class RootController {
    static func index() -> String {
        return Inertia.render(
            component: "Root/Index",
            props: ["degree": "data"],
            url: "/"
        )
    }
    
    static func takePicture(imageManager: ImageManager) -> String {
        print("RootController - takePciture()")
        imageManager.takePicture2()
        
        return "" // Placeholder return value, you can return the response you need
    }
    
    static func show(id: String) -> String {
        return Inertia.render(
            component: "Root/Show",
            props: ["id": id],
            url: "/"
        )
    }
}
