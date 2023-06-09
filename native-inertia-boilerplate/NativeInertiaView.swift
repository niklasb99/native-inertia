//
//  NativeInertiaViewController.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 12.05.23.
//

import SwiftUI
import WebKit

struct NativeInertiaViewController: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        Inertia.setup(webView: webView, router: AppRouter(webView: webView))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update the view if needed
    }
}
