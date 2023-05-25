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
        UITableView.appearance().backgroundColor = .green // Uses UIColor

    }
    
    var body: some View {
        TabView {
            WebViewContainer()
                .tabItem {
                    Image(systemName: "dot.circle")
                    Text("NativeInertia")
                }
                .edgesIgnoringSafeArea(.all)
            
            SwiftViewContainer()
                .tabItem {
                    Image(systemName: "staroflife.circle")
                    Text("NativeSwift")
                }
                .edgesIgnoringSafeArea(.all)
        }
        .accentColor(.black)
    }
}

struct WebViewContainer: View {
    var body: some View {
        NativeInertiaView()
    }
}

struct SwiftViewContainer: View {
    var body: some View {
        NativeSwiftView()
    }
}
