# Labtest2_YourName
### COMP3097 - Lab Test 2
**Name:** Stanley Okafor  
**Student ID:** 101529064

---

## Lab Test 2 - Question

This is open-book assessment. AI code generators are not permitted.
You are asked to build an application using iOS/xCode. App should satisfy the following requirements:

- Name your project using following convention `Labtest2_YourName`
- The application is a tracking position of the user.
- When asking for permission, the popup should show your name and student id (-5 points if missing or showing other text)
- It receives the geo location (GPS) from the device (5 points).
- App should do it on request. When button is pressed current location is pulled. (select best service to do so) (2 points)
- Use a second screen to show coordinates to the user. (3 points)
- Your Name and studentID should be displayed on all screens (-5 points if missing)

Note 1: There is NO persistent storage required.  
Note 2: You can use storyboard or SwiftUI.

---

## Requirements Checklist

| Requirement | How it's satisfied | Points |
|---|---|---|
| Project named Labtest2_YourName | Folder and Xcode project named correctly | - |
| Permission popup shows name + student ID | NSLocationWhenInUseUsageDescription set to "Stanley Okafor - 101529064 needs your location." | -5 if missing |
| GPS coordinates from device | CLLocationManager with kCLLocationAccuracyBest | 5 pts |
| On request (button press) | requestLocation() called only when button tapped - single-shot, not continuous | 2 pts |
| Second screen shows coordinates | CoordinatesView displays lat, lon, altitude via NavigationLink | 3 pts |
| Name + Student ID on all screens | Both ContentView and CoordinatesView display name and ID | -5 if missing |
| No persistent storage | No Core Data, no UserDefaults used | Note 1 |