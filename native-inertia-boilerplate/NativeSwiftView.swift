//
//  NativeSwiftViewController.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 18.05.23.
//

import CoreData
import SwiftUI

struct NativeSwiftView: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var timeItems = [Double: Bool]()
    @State private var fetchStartTime: Double?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(timeItems.keys), id: \.self) { key in
                    let value = timeItems[key]
                    HStack(spacing: 10) {
                        Image(systemName: value! ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 24))
                            .onTapGesture {
                                print("UPDATE")
                                fetchStartTime = Date().timeIntervalSince1970
                                manager.updateBool(for: key)
                                timeItems[key] = !value!
                                try? viewContext.save()
                            }
                        Text("\(key)")
                        Text("ms")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .contextMenu {
                        Button(action: {
                            deleteAllItems()
                        }) {
                            Text("Löschen")
                            Image(systemName: "trash")
                        }
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .background(Color(UIColor(
                red: CGFloat(242) / 255,
                green: CGFloat(242) / 255,
                blue: CGFloat(247) / 255,
                alpha: 1.0
            )))
            
            .onReceive(timeItems.publisher.first()) { _ in
                if let fetchStartTime = fetchStartTime {
                    let fetchEndTime = Date().timeIntervalSince1970
                    let fetchDuration = (fetchEndTime - fetchStartTime)
                    print("Fetch duration: \(fetchDuration*1000) milliseconds")
                }
            }
            .onAppear {
                timeItems = manager.fetchData()
            }
            
            .navigationTitle("Timestamps")
            .toolbar {
                EditButton()
            }
            .navigationBarItems(
                leading: Button(action: deleteAllItems, label: {
                    Image(systemName: "trash")
                }),
                trailing: Button(action: addItem, label: {
                    Image(systemName: "plus")
                })
            )
        }
    }
    
    
    private func addItem() {
        print("CREATE")
        fetchStartTime = Date().timeIntervalSince1970
        manager.addTimestamp()
        timeItems = manager.fetchData()
    }
    
    private func deleteItem(offsets: IndexSet) {
        print("DELETE")
        fetchStartTime = Date().timeIntervalSince1970
        
        for offset in offsets {
            let key = Array(timeItems.keys)[offset]
            manager.deleteTesttimeWithKey(key)
        }
        
        withAnimation {
            timeItems = manager.fetchData()
        }
    }
    
    private func deleteAllItems() {
        manager.deleteAllTimestamps()
        timeItems = manager.fetchData()
    }
}
