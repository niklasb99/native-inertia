//
//  ImagePicker.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 02.06.23.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @ObservedObject var imageManager: ImageManager

    @Binding var images: [String]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(images: $images)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var images: [String]
        
        init(images: Binding<[String]>) {
            _images = images
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                saveImageToDocumentsDirectory(image)
            }
            
            picker.dismiss(animated: true)
        }
        
        func saveImageToDocumentsDirectory(_ image: UIImage) {
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
    }
}

