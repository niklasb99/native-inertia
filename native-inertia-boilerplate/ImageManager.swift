//
//  ImageManager.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 02.06.23.
//

import SwiftUI
import PhotosUI

class ImageManager: NSObject, ObservableObject {
    @Published var images = [String]()
    @Published var showCamera = false // Add the showCamera property
    
    
    func loadImage(imageName: String) -> Image {
        guard let imageURL = getImageURL(imageName: imageName),
              let imageData = try? Data(contentsOf: imageURL),
              let uiImage = UIImage(data: imageData) else {
            return Image(systemName: "photo")
        }
        
        return Image(uiImage: uiImage)
    }
    
    func getImageURL(imageName: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDirectory?.appendingPathComponent(imageName)
    }
    
    func loadSavedImages() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let fileURLs = try? fileManager.contentsOfDirectory(at: documentsDirectory!,
                                                                  includingPropertiesForKeys: nil,
                                                                  options: [.skipsHiddenFiles]) else {
            return
        }
        
        images = fileURLs.map { $0.lastPathComponent }
    }
    
    func deleteImage(imageName: String) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let imageURL = getImageURL(imageName: imageName) else {
            return
        }
        
        do {
            try fileManager.removeItem(at: imageURL)
            images.removeAll(where: { $0 == imageName })
        } catch {
            print("Failed to delete image: \(error)")
        }
    }
    
    func saveTakenImage(_ image: UIImage) {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let imageData = image.jpegData(compressionQuality: 1.0),
              let imageURL = documentsDirectory?.appendingPathComponent("\(UUID().uuidString).jpeg") else {
            return
        }
        
        do {
            try imageData.write(to: imageURL)
            images.append(imageURL.lastPathComponent)
        } catch {
            print("Failed to save image: \(error)")
        }
    }

    
    func takePicture() {
            showCamera = true
        }
    
    func takePicture2() {
       
        let imagePickerController = UIImagePickerController()
           imagePickerController.sourceType = .camera
           imagePickerController.delegate = self // Set the delegate to self
           
           let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
           if let rootViewController = keyWindow?.rootViewController {
               rootViewController.present(imagePickerController, animated: true, completion: nil)
           }
    }
}

extension ImageManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            saveTakenImage(image) // Save the taken image using the new method
        }
        
        picker.dismiss(animated: true)
    }
}



