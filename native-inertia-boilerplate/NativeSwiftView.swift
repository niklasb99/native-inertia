//
//  NativeSwiftViewController.swift
//  native-inertia-boilerplate
//
//  Created by Niklas Burger on 18.05.23.
//

import CoreData
import SwiftUI

struct NativeSwiftView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var timeItems: FetchedResults<Testtime>
    
    @State private var fetchStartTime: Double?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(timeItems) { item in
                    HStack(spacing: 10) {
                        Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 24))
                            .onTapGesture {
                                print("UPDATE")
                                fetchStartTime = Date().timeIntervalSince1970
                                item.isChecked = !item.isChecked
                                try? viewContext.save()
                            }
                        Text("\(item.timestamp)")
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
                .onDelete(perform: deleteItems)
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
                    
                    //print("Fetch duration: \(fetchDuration) seconds")
                    print("Fetch duration: \(fetchDuration*1000) milliseconds")
                }
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
        
        let newTimestamp = Testtime(context: viewContext)
        newTimestamp.timestamp = (Date().timeIntervalSince1970)*1000
        try? viewContext.save()
    }
    
    private func deleteItems(offsets: IndexSet) {
        print("DELETE")
        fetchStartTime = Date().timeIntervalSince1970

        withAnimation {
            offsets.map { timeItems[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete items: \(error)")
            }
        }
    }
    
    private func deleteAllItems() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Testtime")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(batchDeleteRequest)
            try viewContext.save() // Save the changes
            
            // Manually update the fetched results
            let deletedObjects = [NSDeletedObjectsKey: timeItems.map { $0.objectID }]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: deletedObjects, into: [viewContext])
        } catch {
            print("Failed to delete all items: \(error)")
        }
    }
}
