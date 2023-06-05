//
//  NativeSwiftView.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 02.06.23.
//

import SwiftUI
import PhotosUI

struct NativeSwiftView: View {
    @ObservedObject private var imageManager = ImageManager()
    
    var body: some View {
        VStack {
            Button(action: {
                imageManager.takePicture()
            }) {
                Text("Kamera öffnen")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 10) {
                    ForEach(imageManager.images, id: \.self) { imageName in
                        imageManager.loadImage(imageName: imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                            .contextMenu {
                                Button(action: {
                                    imageManager.deleteImage(imageName: imageName)
                                }) {
                                    Text("Bild löschen")
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
        }
        .sheet(isPresented: $imageManager.showCamera) {
            ImagePicker(imageManager: imageManager, images: $imageManager.images)
        }
        .onAppear {
            imageManager.loadSavedImages()
        }
    }
    
    var gridLayout: [GridItem] {
        let gridItem = GridItem(.flexible(), spacing: 10)
        return Array(repeating: gridItem, count: 3)
    }
}
