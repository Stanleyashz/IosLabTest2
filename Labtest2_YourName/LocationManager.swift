//
//  LocationManager.swift
//  Labtest2_YourName
//
//  COMP3097 - Lab Test 2
//  Name: Stanley Okafor
//  Student ID: 101529064
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    // Published so SwiftUI views update automatically
    @Published var latitude:  Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var altitude:  Double = 0.0
    @Published var locationReceived: Bool = false
    @Published var statusMessage: String = ""

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // MARK: - Request single location on button press
    // Using requestLocation() — fires ONCE per button tap (best service for on-demand)
    func requestLocation() {
        locationReceived = false
        statusMessage = "Requesting location..."
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()   // single shot — not continuous updates
    }

    // MARK: - Delegate: location received
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude         = location.coordinate.latitude
            longitude        = location.coordinate.longitude
            altitude         = location.altitude
            locationReceived = true
            statusMessage    = "Location received!"
        }
    }

    // MARK: - Delegate: error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        statusMessage = "Error: \(error.localizedDescription)"
    }

    // MARK: - Delegate: authorization change
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            statusMessage = ""
        case .denied:
            statusMessage = "Location access denied. Enable in Settings."
        case .notDetermined:
            statusMessage = "Waiting for permission..."
        default:
            break
        }
    }
}
