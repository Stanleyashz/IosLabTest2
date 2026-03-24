//
//  GPSExample.swift
//  LabTest2Guide
//
//  Topic: GPS (CoreLocation)
//  Covers: CLLocationManager, delegate, permissions, live coordinates
//
//  ⚠️ REQUIRED in Info.plist:
//     Key:   NSLocationWhenInUseUsageDescription
//     Value: "This app needs your location."
//

import SwiftUI
import CoreLocation

// MARK: - GPS View

struct GPSExample: View {

    @StateObject private var locationViewModel = LocationViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {

                Text("GPS Location")
                    .font(.title)
                    .padding()

                GroupBox(label: Text("Current Location").bold()) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Latitude:  \(locationViewModel.latitude, specifier: "%.6f")")
                        Text("Longitude: \(locationViewModel.longitude, specifier: "%.6f")")
                        Text("Altitude:  \(locationViewModel.altitude, specifier: "%.2f") m")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

                if !locationViewModel.statusMessage.isEmpty {
                    Text(locationViewModel.statusMessage)
                        .foregroundColor(.gray)
                        .font(.caption)
                }

                HStack(spacing: 16) {
                    Button("Start GPS") {
                        locationViewModel.startUpdating()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Button("Stop GPS") {
                        locationViewModel.stopUpdating()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("GPS")
            .onAppear {
                locationViewModel.startUpdating()
            }
        }
    }
}


// MARK: - LocationViewModel

// Wraps CLLocationManager for SwiftUI observation
class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    @Published var latitude:  Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var altitude:  Double = 0.0
    @Published var statusMessage: String = ""

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func startUpdating() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }

    // Called every time a new location arrives
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude  = location.coordinate.latitude
            longitude = location.coordinate.longitude
            altitude  = location.altitude
        }
    }

    // Called if something goes wrong
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        statusMessage = "Error: \(error.localizedDescription)"
    }

    // Called when the user changes permission
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            statusMessage = "Location authorized"
        case .denied:
            statusMessage = "Location denied — check Settings"
        case .notDetermined:
            statusMessage = "Waiting for permission..."
        default:
            statusMessage = ""
        }
    }
}


// MARK: - Preview

struct GPSExample_Previews: PreviewProvider {
    static var previews: some View {
        GPSExample()
    }
}
