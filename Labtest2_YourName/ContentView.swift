//
//  ContentView.swift
//  Labtest2_YourName
//
//  COMP3097 - Lab Test 2
//  Name: Stanley Okafor
//  Student ID: 101529064
//

import SwiftUI
import CoreLocation

struct ContentView: View {

    @StateObject private var locationManager = LocationManager()
    @State private var navigateToCoordinates = false

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {

                // ── Student Info (required on all screens) ──
                VStack(spacing: 4) {
                    Text("Stanley Okafor")
                        .font(.headline)
                    Text("Student ID: 101529064")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)

                Spacer()

                // ── App Title ──
                Text("Position Tracker")
                    .font(.largeTitle)
                    .bold()

                Text("Tap the button to get your current location.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // ── Status message ──
                if !locationManager.statusMessage.isEmpty {
                    Text(locationManager.statusMessage)
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(.horizontal)
                }

                // ── Get Location Button ──
                Button(action: {
                    locationManager.requestLocation()
                }) {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Get Current Location")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

                // ── Navigate to second screen once location is available ──
                if locationManager.locationReceived {
                    NavigationLink(
                        destination: CoordinatesView(locationManager: locationManager),
                        isActive: $navigateToCoordinates
                    ) {
                        EmptyView()
                    }

                    Button(action: {
                        navigateToCoordinates = true
                    }) {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("View Coordinates")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }

                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
