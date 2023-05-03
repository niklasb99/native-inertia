//
//  ContentView.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import SwiftUI
import WebKit

struct ContentView: UIViewControllerRepresentable {    
    typealias UIViewControllerType = ContentViewController

    func makeUIViewController(context: Context) -> ContentViewController {
        return ContentViewController()
    }

    func updateUIViewController(_ uiViewController: ContentViewController, context: Context) {
        // Update the view controller when required
    }
}
