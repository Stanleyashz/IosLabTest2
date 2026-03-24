# Labtest2_YourName
### COMP3097 – Lab Test 2
**Name:** Stanley Okafor  
**Student ID:** 101529064

---

## Requirements Checklist

| Requirement | How it's satisfied | Points |
|---|---|---|
| Project named `Labtest2_YourName` | Folder and Xcode project named correctly | — |
| Permission popup shows name + student ID | `NSLocationWhenInUseUsageDescription` in Info.plist set to "Stanley Okafor - 101529064 needs your location." | -5 if missing |
| GPS coordinates from device | `CLLocationManager` with `kCLLocationAccuracyBest` | 5 pts |
| On request (button press) | `requestLocation()` called only when button tapped — single-shot, not continuous | 2 pts |
| Second screen shows coordinates | `CoordinatesView` displays lat, lon, altitude via `NavigationLink` | 3 pts |
| Name + Student ID on all screens | Both `ContentView` and `CoordinatesView` display name and ID | -5 if missing |
| No persistent storage | No Core Data, no UserDefaults used | Note 1 |

---

## Files

```
Labtest2_YourName/
├── Labtest2_YourNameApp.swift   ← App entry point
├── ContentView.swift             ← Screen 1: button to get location
├── CoordinatesView.swift         ← Screen 2: displays coordinates
└── LocationManager.swift         ← CLLocationManager wrapper
```

---

## Setup in Xcode

1. Open `Labtest2_YourName.xcodeproj`
2. Go to the project target → **Info** tab
3. Add key: `NSLocationWhenInUseUsageDescription`  
   Value: `Stanley Okafor - 101529064 needs your location.`
4. Build and run on a real device or simulator with location enabled

---

## Why `requestLocation()` ?

The question says *"on request"* and to *"select best service"*.  
`requestLocation()` fires **once per tap** and automatically stops — it's the correct single-shot service vs `startUpdatingLocation()` which runs continuously and drains battery.
