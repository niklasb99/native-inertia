//
//  NativeInertiaViewController.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 25.05.23.
//

import SwiftUI
import WebKit

struct NativeInertiaView: UIViewRepresentable {
    @ObservedObject var compassHeading = CompassHeading()

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
       // webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.configuration.userContentController.addUserScript(self.getZoomDisableScript())

        Inertia.setup(webView: webView, router: AppRouter(webView: webView))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update the view if needed
       /* DispatchQueue.main.async {
            // Code für den SSE-Verbindungsaufbau und Benutzeroberflächenaktualisierungen hier
            startSSEConnection()
        }
*/
    }
    
    // Disable zoom for native feeling
    private func getZoomDisableScript() -> WKUserScript {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
}

/*
struct NativeInertiaView: View {
    @ObservedObject var compassHeading = CompassHeading()
    
    var body: some View {
        VStack {
            Text("\(Int(self.compassHeading.degrees)*(-1))°")
                .font(.title)
                .bold()
        }
        
    }
}
*/
