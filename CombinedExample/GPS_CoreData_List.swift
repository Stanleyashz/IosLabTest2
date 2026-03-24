//
//  GPS_CoreData_List.swift
//  LabTest2Guide
//
//  🔥 MOST LIKELY EXAM SCENARIO
//  Flow: Get GPS location → Save to Core Data → Display in List → Swipe to Delete
//
//  Assumes a Core Data entity "LocationEntry" with:
//    - id:        UUID
//    - latitude:  Double
//    - longitude: Double
//    - timestamp: Date
//
//  ⚠️ Add to Info.plist:
//     NSLocationWhenInUseUsageDescription → "This app needs your location."
//

import SwiftUI
import CoreLocation
import CoreData


// MARK: - App Entry Point
//
// In your labTest2App.swift file:
//
// @main
// struct labTest2App: App {
//     let persistenceController = PersistenceController.shared
//     var body: some Scene {
//         WindowGroup {
//             GPS_CoreData_ListView()
//                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
//         }
//     }
// }


// MARK: - Main View

struct GPS_CoreData_ListView: View {

    @Environment(\.managedObjectContext) private var viewContext

    // Auto-refreshes list whenever Core Data changes
    @FetchRequest(
        entity: LocationEntry.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LocationEntry.timestamp, ascending: false)
        ]
    ) var savedLocations: FetchedResults<LocationEntry>

    @StateObject private var locationViewModel = LocationViewModel()

    var body: some View {
        NavigationView {
            VStack {

                // --- Current GPS Reading ---
                GroupBox(label: Text("Current Location").bold()) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Lat:  \(locationViewModel.latitude,  specifier: "%.6f")")
                        Text("Lon:  \(locationViewModel.longitude, specifier: "%.6f")")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
                }
                .padding(.horizontal)

                // --- Save Button ---
                Button("Save Location") {
                    saveLocation()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                // --- Saved Locations List ---
                List {
                    ForEach(savedLocations) { entry in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Lat: \(entry.latitude,  specifier: "%.5f")")
                            Text("Lon: \(entry.longitude, specifier: "%.5f")")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(entry.timestamp ?? Date(), style: .date)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteEntries)
                }
            }
            .navigationTitle("GPS Tracker")
            .onAppear {
                locationViewModel.startUpdating()
            }
        }
    }

    // MARK: Save current GPS coords to Core Data
    private func saveLocation() {
        let newEntry = LocationEntry(context: viewContext)
        newEntry.id        = UUID()
        newEntry.latitude  = locationViewModel.latitude
        newEntry.longitude = locationViewModel.longitude
        newEntry.timestamp = Date()

        try? viewContext.save()
        // @FetchRequest automatically refreshes the List — no reload needed
    }

    // MARK: Delete
    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            offsets.map { savedLocations[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}


// MARK: - LocationViewModel (GPS)

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    @Published var latitude:  Double = 0.0
    @Published var longitude: Double = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func startUpdating() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude  = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}


// MARK: - Preview

struct GPS_CoreData_List_Previews: PreviewProvider {
    static var previews: some View {
        GPS_CoreData_ListView()
            .environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
    }
}
