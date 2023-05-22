//
//  NativeSwiftViewController.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 12.05.23.
//

import SwiftUI

struct NativeSwiftViewController: View {
    
    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationView {
            NavigationStack {
                Spacer()
                
                Text("Requirement 1")
                    .font(.title)
                
                Text("Routing")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: PageView(pageNumber: 1, color: .blue )) {
                    Text("Page 1")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                .padding()
                .simultaneousGesture(TapGesture().onEnded {
                    print("Button Click Time", Date().timeIntervalSince1970)
                })
                
                NavigationLink(destination: PageView(pageNumber: 2, color: .green)) {
                    Text("Page 2")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                .padding()
                .simultaneousGesture(TapGesture().onEnded {
                    print("Button Click Time", Date().timeIntervalSince1970)
                })
                
                NavigationLink(destination: PageView(pageNumber: 3, color: .orange)) {
                    Text("Page 3")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                .padding()
                .simultaneousGesture(TapGesture().onEnded {
                    print("Button Click Time", Date().timeIntervalSince1970)
                })
                
                Spacer()
            }
        }
        .accentColor(.white)
    }
}

struct PageView: View {
    let pageNumber: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text("Page \(pageNumber)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()
            
            Text("Opened at: \(formatter())")
                .foregroundColor(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accentColor(.white)
        .background(color)
        .onAppear {
            let appearTime = Date().timeIntervalSince1970
            print("View Appear Time", appearTime)
        }
    }
    
    func formatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let now = Date()
        let timeFormatted = dateFormatter.string(from: now)    
        return timeFormatted
    }
}
