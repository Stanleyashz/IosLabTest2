//
//  ListViewExample.swift
//  LabTest2Guide
//
//  Topic: List / Table View
//  Pattern: matches labex6.1 (List + NavigationLink) and labex7.1 (ForEach + onDelete)
//

import SwiftUI


// MARK: - Basic List (static data)

struct BasicListView: View {

    let items = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Fruits")
        }
    }
}


// MARK: - List with ForEach + onDelete (matches labex7)

struct EditableListView: View {

    @State private var items = ["Item 1", "Item 2", "Item 3"]

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: deleteItem)  // swipe to delete
            }
            .navigationTitle("Items")
            .toolbar {
                // EditButton enables swipe-to-delete UI
                EditButton()
            }
        }
    }

    private func deleteItem(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}


// MARK: - List with NavigationLink to Detail (matches labex7 ContentView)

struct NavigableListView: View {

    let students = ["Alice", "Bob", "Charlie"]

    var body: some View {
        NavigationView {
            List {
                ForEach(students, id: \.self) { name in
                    NavigationLink(destination: StudentDetailView(name: name)) {
                        VStack(alignment: .leading) {
                            Text(name)
                                .font(.headline)
                            Text("Tap to view details")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Students")
            .toolbar {
                Button(action: { /* add action */ }) {
                    Label("Add", systemImage: "plus")  // matches labex7 toolbar style
                }
            }
        }
    }
}

struct StudentDetailView: View {
    var name: String

    var body: some View {
        VStack(spacing: 16) {
            Text(name)
                .font(.title)
            Spacer()
        }
        .padding()
        .navigationTitle(name)
    }
}


// MARK: - List with Custom Row + AsyncImage (matches labex6)

struct PhotoListView: View {

    // In the real exam this might come from an API or Core Data
    let photos = [
        PhotoItem(title: "Mountain Sunrise", url: "https://via.placeholder.com/60"),
        PhotoItem(title: "Ocean View",        url: "https://via.placeholder.com/60"),
        PhotoItem(title: "City Skyline",      url: "https://via.placeholder.com/60")
    ]

    var body: some View {
        NavigationView {
            List(photos) { photo in
                HStack {
                    AsyncImage(url: URL(string: photo.url)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)

                    Text(photo.title)
                        .font(.caption)
                }
            }
            .navigationTitle("Photos")
        }
    }
}

struct PhotoItem: Identifiable {
    let id = UUID()
    let title: String
    let url: String
}


// MARK: - Preview

struct ListViewExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigableListView()
    }
}
