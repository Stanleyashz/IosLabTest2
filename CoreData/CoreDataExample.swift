//
//  CoreDataExample.swift
//  LabTest2Guide
//
//  Topic: Core Data – CRUD Operations
//  Pattern: matches labex7.1 (ContentView + StudentFormView style)
//
//  Assumes a Core Data entity called "LocationEntry" with attributes:
//    - id:        UUID
//    - latitude:  Double
//    - longitude: Double
//    - timestamp: Date
//
//  ⚠️ You must create this entity in your .xcdatamodeld file manually
//

import SwiftUI
import CoreData


// MARK: - List View (Read + Delete)

struct CoreDataListView: View {

    // Pull context from environment — injected in App entry point
    @Environment(\.managedObjectContext) private var viewContext

    // @FetchRequest auto-updates the List when data changes
    @FetchRequest(
        entity: LocationEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LocationEntry.timestamp, ascending: false)
        ]
    ) var entries: FetchedResults<LocationEntry>

    @State private var showAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    // Tap row → go to edit form (matches labex7 NavigationLink style)
                    NavigationLink(destination: CoreDataFormView(entry: entry)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Lat: \(entry.latitude, specifier: "%.5f")")
                            Text("Lon: \(entry.longitude, specifier: "%.5f")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteEntries)  // swipe to delete
            }
            .navigationTitle("Saved Locations")
            .toolbar {
                Button(action: { showAddView = true }) {
                    Label("Add", systemImage: "plus")  // matches labex7 toolbar
                }
            }
            .sheet(isPresented: $showAddView) {
                CoreDataFormView(entry: nil)
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    // MARK: Delete
    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}


// MARK: - Form View (Create + Update)

struct CoreDataFormView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss  // matches labex7 StudentFormView

    var entry: LocationEntry?   // nil = create new, non-nil = edit existing

    @State private var latitudeText  = ""
    @State private var longitudeText = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Coordinates")) {
                    TextField("Latitude",  text: $latitudeText)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $longitudeText)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle(entry == nil ? "Add Location" : "Edit Location")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveEntry()
                    }
                }
            }
            .onAppear {
                loadData()  // populate fields if editing
            }
        }
    }

    // MARK: Load existing data into form fields
    private func loadData() {
        if let entry = entry {
            latitudeText  = String(entry.latitude)
            longitudeText = String(entry.longitude)
        }
    }

    // MARK: Save (Create or Update)
    private func saveEntry() {
        // If editing, use existing object. If creating, make a new one.
        let e = entry ?? LocationEntry(context: viewContext)

        if e.id == nil {
            e.id = UUID()
        }

        e.latitude  = Double(latitudeText)  ?? 0.0
        e.longitude = Double(longitudeText) ?? 0.0
        e.timestamp = Date()

        try? viewContext.save()
        dismiss()
    }
}


// MARK: - Standalone Save / Fetch / Delete Snippets
//
// Use these if you need quick inline operations
// (not inside a Form — just direct context calls)

/*

 // ── SAVE ──
 let newEntry = LocationEntry(context: viewContext)
 newEntry.id        = UUID()
 newEntry.latitude  = 43.6532
 newEntry.longitude = -79.3832
 newEntry.timestamp = Date()
 try? viewContext.save()


 // ── FETCH (manual, without @FetchRequest) ──
 let request: NSFetchRequest<LocationEntry> = LocationEntry.fetchRequest()
 request.sortDescriptors = [NSSortDescriptor(keyPath: \LocationEntry.timestamp, ascending: false)]
 let results = try? viewContext.fetch(request)


 // ── DELETE ──
 if let first = results?.first {
     viewContext.delete(first)
     try? viewContext.save()
 }

*/


// MARK: - Preview

struct CoreDataExample_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataListView()
            .environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
    }
}
