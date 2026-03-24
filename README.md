# 📱 Lab Test 2 – Open Book Reference Guide
### COMP3097 – Mobile Application Development II

> **Topics:** Navigation • Sensors • GPS • List/Table View • Core Data  
> **Format:** SwiftUI only — matches lab style from labex6.1 and labex7.1

---

## 📁 Repo Structure

```
LabTest2Guide/
│
├── README.md                        ← You are here
│
├── Navigation/
│   └── NavigationExample.swift      ← NavigationView, NavigationLink, NavigationStack
│
├── Sensors/
│   └── SensorsExample.swift         ← CMMotionManager (accelerometer, gyroscope)
│
├── GPS/
│   └── GPSExample.swift             ← CLLocationManager, delegate, permissions
│
├── ListView/
│   └── ListViewExample.swift        ← SwiftUI List, ForEach, onDelete, NavigationLink
│
├── CoreData/
│   ├── PersistenceController.swift  ← Shared context setup (matches labex7 style)
│   └── CoreDataExample.swift        ← Save, Fetch, Delete, @FetchRequest
│
└── CombinedExample/
    └── GPS_CoreData_List.swift      ← Full flow: GPS → Core Data → List
```

---

## 🧭 Quick Topic Index

| Topic | File | Key Pattern |
|---|---|---|
| Navigation | `Navigation/NavigationExample.swift` | `NavigationView` + `NavigationLink` |
| Sensors | `Sensors/SensorsExample.swift` | `CMMotionManager` |
| GPS | `GPS/GPSExample.swift` | `CLLocationManagerDelegate` |
| List View | `ListView/ListViewExample.swift` | `List` + `ForEach` + `onDelete` |
| Core Data | `CoreData/CoreDataExample.swift` | `@FetchRequest` + `@Environment` |
| All Together | `CombinedExample/GPS_CoreData_List.swift` | Full exam scenario |

---

## ⚡ Before You Start the Test

- [ ] Create new Xcode project (SwiftUI, not Storyboard)
- [ ] Add `NSLocationWhenInUseUsageDescription` to Info.plist if using GPS
- [ ] Add Core Data model file (`.xcdatamodeld`) if using Core Data
- [ ] Set up `PersistenceController` and pass context in `App` entry point
- [ ] Import correct frameworks (`CoreMotion`, `CoreLocation`, `CoreData`)

---

## 🔥 Most Likely Exam Scenario

> Get GPS → Save to Core Data → Display in List

**Flow:**
1. `CLLocationManager` gets coordinates
2. Save lat/long to Core Data entity
3. `@FetchRequest` pulls saved locations
4. `List` + `ForEach` displays them
5. `onDelete` removes entries

See → `CombinedExample/GPS_CoreData_List.swift`

---

## 💡 Key Reminders

- Always set `delegate = self` for location manager
- Always call `.requestWhenInUseAuthorization()` before starting updates
- Always pass `\.managedObjectContext` via `.environment()` in the App entry point
- Use `try? viewContext.save()` after every create/delete
- Use `tableView.reloadData()` → in SwiftUI this is automatic via `@FetchRequest`
