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
    
    static func getImages() -> [[String: String]] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            var images: [[String: String]] = []
            
            for item in items {
                if let imageData = item.imageItem,
                   let uiImage = UIImage(data: imageData),
                   let pngData = uiImage.jpegData(compressionQuality: 1.0) {
                    let base64String = pngData.base64EncodedString()
                    let id = item.imageId?.uuidString ?? ""
                    
                    let imageDict: [String: String] = ["image": base64String, "id": id]
                    images.append(imageDict)
                }
            }
            
            return images
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    static func delete(id: String) -> String {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imageId == %@", id)
        
        print("delete aufruf", id)
        do {
            let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            if let item = items.first {
                PersistenceController.shared.container.viewContext.delete(item)
                
                do {
                    try PersistenceController.shared.container.viewContext.save()
                    print("Bild gelöscht")
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return RootController.index()
    }
}
