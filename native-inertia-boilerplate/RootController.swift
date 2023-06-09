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
        print(getImages2())
        
        return Inertia.render(
            component: "Root/Index",
            props: ["images": getImages2()],
            url: "/"
        )
    }
    
    static func takePicture(imageManager: ImageManager) -> String {
        print("RootController - takePicture()")
        imageManager.takePicture2()
        
        return "" // Placeholder return value, you can return the response you need
    }
    
    static func getImages2() -> String {
        let images = fetchImagesFromCoreData()
        let compressedImages = images.compactMap { compressImage($0) }
        let imageStrings = compressedImages.map { imageToBase64String($0) }
        
        let props = imageStrings
        
        let json = try? JSONSerialization.data(withJSONObject: props, options: [])
        if let jsonData = json, let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
        
        return ""
    }
    
    private static func compressImage(_ imageData: Data) -> Data? {
        guard let uiImage = UIImage(data: imageData) else {
            return nil
        }
        
        guard let compressedData = uiImage.jpegData(compressionQuality: 0.001) else {
            return nil
        }
        
        return compressedData
    }
    
    private static func fetchImagesFromCoreData() -> [Data] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            let images = items.compactMap { $0.imageItem }
            print(images)
            return images
        } catch {
            return []
        }
    }
    
    private static func imageToBase64String(_ imageData: Data) -> String {
        return imageData.base64EncodedString()
    }
}
