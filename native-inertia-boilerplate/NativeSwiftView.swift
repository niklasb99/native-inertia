import SwiftUI

struct NativeSwiftViewController: View {
    var body: some View {
        TabView {
            PageView(pageNumber: 1, color: .blue)
                .tabItem {
                    Label("Page 1", systemImage: "1.circle")
                }
            
            PageView(pageNumber: 2, color: .orange)
                .tabItem {
                    Label("Page 2", systemImage: "2.circle")
                }
            
            PageView(pageNumber: 3, color: .green)
                .tabItem {
                    Label("Page 3", systemImage: "3.circle")
                }
        }
        .accentColor(.white)
        .tabViewStyle(PageTabViewStyle())
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
