//
//  ContentView.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    init() {
            UITabBar.appearance().tintColor = .black
        }
    
    var body: some View {
        TabView {
            WebViewContainer()
                .tabItem {
                    Image(systemName: "dot.circle")
                    Text("NativeInertia")
                }
                
            SwiftViewContainer()
                            .tabItem {
                                Image(systemName: "staroflife.circle")
                                Text("NativeSwift")
                            }
        }
        .accentColor(.black)
    }
        
}

struct WebViewContainer: View {
    var body: some View {
            NativeInertiaView()
            .background(Color(UIColor(
                red: CGFloat(242) / 255,
                green: CGFloat(242) / 255,
                blue: CGFloat(247) / 255,
                alpha: 1.0
            )))

    }
}

struct SwiftViewContainer: View {
    var body: some View {
        NativeSwiftView()
    }
}
