//
//  ImageManager.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 02.06.23.
//

import CoreData
import UIKit

class ImageManager: NSObject, ObservableObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func takePicture() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            saveImageToCoreData(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImageToCoreData(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            // Fehler beim Konvertieren des Bildes in Daten
            return
        }
        
        let newItem = Item(context: PersistenceController.shared.container.viewContext)
        newItem.imageItem = imageData
        newItem.imageId = UUID()
        
        do {
            try PersistenceController.shared.container.viewContext.save()
            print("Bild gespeichert")
        } catch {
            print(error.localizedDescription)
        }
    }
}



