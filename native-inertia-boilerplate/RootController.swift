//
//  IndexController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//
import SwiftUI
import CoreData

class RootController {
    
    static func index() -> String {
        return Inertia.render(
            component: "Root/Index",
            props: ["images": getImages()],
            
            url: "/"
        )
    }
    
    static func takePicture(imageManager: ImageManager) -> String {
        print("RootController - takePicture()")
        imageManager.takePicture()
        
        return ""
    }
    
    static func getImages() -> [[String: Any]] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            var images: [[String: Any]] = []
            
            for item in items {
                if let imageData = item.imageItem,
                   let uiImage = UIImage(data: imageData),
                   let jpegData = uiImage.jpegData(compressionQuality: 0.001) {
                    let base64String = jpegData.base64EncodedString()
                    let id = item.imageId?.uuidString ?? ""
                    let fileSize = jpegData.count
                    
                    print(fileSize)
                    
                    let imageDict: [String: Any] = ["image": base64String, "id": id, "fileSize": fileSize]
                    images.append(imageDict)
                }
            }
            return images
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    
    static func delete(imageManager: ImageManager, id: String) -> String {
        imageManager.delete(id: id)
        return RootController.index()
    }
}
