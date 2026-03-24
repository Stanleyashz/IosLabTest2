//
//  NavigationExample.swift
//  LabTest2Guide
//
//  Topic: Navigation
//  Pattern: NavigationView + NavigationLink (matches labTest1 + labex7 style)
//

import SwiftUI

// MARK: - Main View (Entry Point)

struct NavigationExample: View {

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Main Screen")
                    .font(.title)
                    .padding()

                // Basic NavigationLink — go to a plain view
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second Screen")
                        .foregroundColor(.blue)
                }

                // Pass data to next screen
                NavigationLink(destination: DetailView(message: "Hello from Main")) {
                    Text("Go to Detail (with data)")
                        .foregroundColor(.blue)
                }

                // Programmatic navigation using @State
                NavigationLink(
                    destination: SecondView(),
                    isActive: $navigateToSecond
                ) {
                    EmptyView()
                }

                Button("Navigate Programmatically") {
                    navigateToSecond = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }

    @State private var navigateToSecond = false
}


// MARK: - Second View

struct SecondView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Second Screen")
                .font(.title)
                .padding()

            // Pop back is handled automatically by the back button
            // No need to call popViewController in SwiftUI

            Spacer()
        }
        .padding()
        .navigationTitle("Second")
    }
}


// MARK: - Detail View (receives data)

struct DetailView: View {

    var message: String   // data passed from previous screen

    var body: some View {
        VStack(spacing: 20) {
            Text("Detail Screen")
                .font(.title)
                .padding()

            Text("Received: \(message)")
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
    }
}


// MARK: - Sheet (Modal) Navigation

struct SheetExample: View {

    @State private var showSheet = false

    var body: some View {
        Button("Open Sheet") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            ModalView()
        }
    }
}

struct ModalView: View {

    @Environment(\.dismiss) private var dismiss  // matches labex7 StudentFormView

    var body: some View {
        VStack {
            Text("Modal View")
                .font(.title)
                .padding()

            Button("Close") {
                dismiss()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}


// MARK: - Preview

struct NavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationExample()
    }
}
