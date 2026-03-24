//
//  CoordinatesView.swift
//  Labtest2_YourName
//
//  COMP3097 - Lab Test 2
//  Name: Stanley Okafor
//  Student ID: 101529064
//

import SwiftUI

struct CoordinatesView: View {

    @ObservedObject var locationManager: LocationManager

    var body: some View {
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

            // ── Coordinates Display ──
            Text("Current Location")
                .font(.largeTitle)
                .bold()

            VStack(spacing: 16) {
                CoordinateRow(
                    label: "Latitude",
                    value: String(format: "%.6f", locationManager.latitude),
                    icon: "arrow.up.arrow.down"
                )
                CoordinateRow(
                    label: "Longitude",
                    value: String(format: "%.6f", locationManager.longitude),
                    icon: "arrow.left.arrow.right"
                )
                CoordinateRow(
                    label: "Altitude",
                    value: String(format: "%.2f m", locationManager.altitude),
                    icon: "mountain.2.fill"
                )
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Coordinates")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Coordinate Row Component

struct CoordinateRow: View {
    var label: String
    var value: String
    var icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 28)
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .bold()
                .font(.system(.body, design: .monospaced))
        }
        .padding(.vertical, 4)
    }
}

struct CoordinatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoordinatesView(locationManager: LocationManager())
        }
    }
}
