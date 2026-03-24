//
//  PersistenceController.swift
//  LabTest2Guide
//
//  Topic: Core Data – Context Setup
//  Pattern: matches labex7.1 Persistence.swift exactly
//
//  HOW TO USE:
//  1. Create a Core Data model file: File → New → File → Data Model
//     Name it to match your project (e.g. "labTest2")
//  2. Add your Entities in the .xcdatamodeld editor
//  3. Pass context into the view hierarchy from your App entry point (see bottom)
//

import CoreData

struct PersistenceController {

    // Shared singleton — use this everywhere
    static let shared = PersistenceController()

    // In-memory store for SwiftUI Previews (no disk writes)
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Add sample data for preview here
        // Example:
        // let item = LocationEntry(context: viewContext)
        // item.id = UUID()
        // item.latitude = 43.6532
        // item.longitude = -79.3832

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // ⚠️ "labTest2" must match the name of your .xcdatamodeld file
        container = NSPersistentContainer(name: "labTest2")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        // Auto-merge changes from background contexts
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}


/*
 ──────────────────────────────────────────────
 App Entry Point — pass context into SwiftUI
 ──────────────────────────────────────────────

 @main
 struct labTest2App: App {
     let persistenceController = PersistenceController.shared

     var body: some Scene {
         WindowGroup {
             ContentView()
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
         }
     }
 }
 */
