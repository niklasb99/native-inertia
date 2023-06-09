//
//  NativeSwiftView.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 02.06.23.
//

import SwiftUI
import CoreData

struct NativeSwiftView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: []) var items: FetchedResults<Item>

    @State private var showCamera = false
    @State private var newImage: UIImage?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Camera - Feature")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button(action: {
                showCamera = true
            }) {
                Text("Kamera öffnen")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }

            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        if let imageData = item.imageItem {
                            let image = UIImage(data: imageData)
                            if let uiImage = image {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                    .contextMenu {
                                        Button(action: {
                                            deleteItem(item)
                                        }) {
                                            Text("Bild löschen")
                                            Image(systemName: "trash")
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
        .sheet(isPresented: $showCamera, onDismiss: saveImageToCoreData) {
            ImagePicker(image: $newImage)
        }
        .onAppear {
            loadImageFromCoreData()
        }
    }

    var gridLayout: [GridItem] {
        let gridItem = GridItem(.flexible(), spacing: 10)
        return Array(repeating: gridItem, count: 3)
    }

    private func saveImageToCoreData() {
        guard let image = newImage,
              let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }

        let newItem = Item(context: viewContext)
        newItem.imageItem = imageData

        do {
            try viewContext.save()
            print("Bild gespeichert")
        } catch {
            print(error.localizedDescription)
        }
    }

    private func deleteItem(_ item: Item) {
        viewContext.delete(item)
        do {
            try viewContext.save()
            print("Bild gelöscht")
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadImageFromCoreData() {
        // Fetch and load images from CoreData
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

