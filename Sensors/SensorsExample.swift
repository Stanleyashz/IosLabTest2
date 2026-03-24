//
//  SensorsExample.swift
//  LabTest2Guide
//
//  Topic: Sensors (CoreMotion)
//  Covers: Accelerometer, Gyroscope — displayed live in SwiftUI
//

import SwiftUI
import CoreMotion

// MARK: - Sensors View

struct SensorsExample: View {

    // Use a class to hold CMMotionManager (it's not a struct)
    @StateObject private var motionViewModel = MotionViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {

                Text("Sensors")
                    .font(.title)
                    .padding()

                // --- Accelerometer ---
                GroupBox(label: Text("Accelerometer").bold()) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("X: \(motionViewModel.accelX, specifier: "%.4f")")
                        Text("Y: \(motionViewModel.accelY, specifier: "%.4f")")
                        Text("Z: \(motionViewModel.accelZ, specifier: "%.4f")")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

                // --- Gyroscope ---
                GroupBox(label: Text("Gyroscope").bold()) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("X: \(motionViewModel.gyroX, specifier: "%.4f")")
                        Text("Y: \(motionViewModel.gyroY, specifier: "%.4f")")
                        Text("Z: \(motionViewModel.gyroZ, specifier: "%.4f")")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

                // --- Controls ---
                HStack(spacing: 16) {
                    Button("Start") {
                        motionViewModel.startUpdates()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    Button("Stop") {
                        motionViewModel.stopUpdates()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Sensors")
            .onAppear {
                motionViewModel.startUpdates()  // auto-start when view appears
            }
            .onDisappear {
                motionViewModel.stopUpdates()   // stop when leaving view
            }
        }
    }
}


// MARK: - MotionViewModel

// Wraps CMMotionManager so SwiftUI can observe changes
class MotionViewModel: ObservableObject {

    private let motionManager = CMMotionManager()

    // Accelerometer
    @Published var accelX: Double = 0.0
    @Published var accelY: Double = 0.0
    @Published var accelZ: Double = 0.0

    // Gyroscope
    @Published var gyroX: Double = 0.0
    @Published var gyroY: Double = 0.0
    @Published var gyroZ: Double = 0.0

    func startUpdates() {

        // --- Accelerometer ---
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                if let acc = data?.acceleration {
                    self.accelX = acc.x
                    self.accelY = acc.y
                    self.accelZ = acc.z
                }
            }
        }

        // --- Gyroscope ---
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: .main) { data, error in
                if let gyro = data?.rotationRate {
                    self.gyroX = gyro.x
                    self.gyroY = gyro.y
                    self.gyroZ = gyro.z
                }
            }
        }
    }

    func stopUpdates() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
}


// MARK: - Preview

struct SensorsExample_Previews: PreviewProvider {
    static var previews: some View {
        SensorsExample()
    }
}
