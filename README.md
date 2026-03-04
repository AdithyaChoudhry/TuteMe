# Tute-Me — Cross-Platform Tutor Discovery App

A cross-platform mobile application built with **Flutter** and **Firebase** that connects students with tutors through real-time geolocation, intelligent filtering, and an interactive review system.

## Architecture

```
lib/
├── main.dart                  # App entry point, route configuration, Firebase init
├── homepage.dart              # Home screen with real-time teacher listings via Firebase streams
├── login.dart                 # Role-based login (Student/Teacher) with dropdown selection
├── register.dart              # Student registration with form validation
├── listingnew.dart            # Tutor registration with geocoded address, subjects, classes, mode
├── map.dart                   # Google Maps integration with real-time tutor markers & area search
├── filters.dart               # 6-category filter system (Mode, Subject, Type, Price, Class, Area)
├── details.dart               # Tutor detail view with PageView gallery, chips, and review links
├── review.dart                # 5-dimension rating system with Firebase write-back
├── viewreviews.dart           # Review listing with Firebase stream subscription
├── favourites.dart            # Tutor card widget with FutureBuilder and Firebase fetch
├── favourites_expanded.dart   # Full teacher listing with search and filter access
├── profile.dart               # Student profile with tabbed My Teachers / My Subjects view
├── teacherprofile.dart        # Teacher profile with edit/view and request management
├── editprofile.dart           # Teacher profile editor with image picker (camera/gallery)
├── studentprofile.dart        # Student profile editor with image picker
├── student_register.dart      # Student-facing tutor browsing with drawer navigation
├── cards.dart                 # Reusable product card widget (image, title, description, price)
├── categories.dart            # Category card layout widget
├── horizontal_categories.dart # Horizontal scrollable category widget
├── books.dart                 # Book listing module
├── cycles.dart                # Cycle listing module
├── user.dart                  # User data model (name, email, subject, address, fees, etc.)
├── userprefernce.dart         # Static user preferences/defaults
├── profilewidget.dart         # Reusable profile image widget with edit overlay
├── textfield.dart             # Reusable labeled text field widget
├── template.dart              # Base scaffold template
├── forgotpassword.dart        # Forgot password screen with OTP flow
└── resetpassword.dart         # Reset password screen
```

##  Key Features

### Real-Time Tutor Geolocation
- Google Maps integration with live tutor markers fetched via Firebase `onValue` stream listeners
- User location detection using `Geolocator` with permission handling
- Area search with `Geocoder` address-to-coordinate resolution and camera animation
- Autocomplete search across **150+ Chennai localities** with in-memory filtering
- Satellite/normal map type toggle
- Interactive marker tap cards displaying tutor name and details

### 6-Category Filter System
- **Mode** — Online / Offline
- **Subjects** — Searchable list with real-time autocomplete
- **Type** — Group / Individual
- **Price** — 5 price range brackets (₹500–10,000+)
- **Class** — Classes 1–12 with checkbox selection
- **Area** — 150+ searchable localities with checkbox filtering
- Dynamic chip-based applied filter display with individual removal
- Sub-100ms filtered results via in-memory search on pre-loaded data

### Role-Based Navigation
- **Guest** — Browse tutors, view map, register as tutor, login prompt
- **Student** — Full access to profiles, favourites, reviews, tutor discovery
- **Teacher** — Profile management, edit listing, view student requests
- Conditional UI rendering based on user role across all screens

### Multi-Criteria Review System
- 5-dimension rating: Communication, Punctuality, Doubt Session, Lecture Delivery, Overall
- Half-star precision rating bars with drag-to-rate interaction
- Text review input with Firebase Realtime Database write-back
- Review listing page with stream-based live updates
- Success confirmation dialogs with loading states

### Tutor Registration & Profile Management
- Comprehensive tutor registration form with 10+ validated fields
- Dynamic chip-based selection for classes (1–12), subjects, mode, and type
- Address geocoding via `Geocoder` for automatic latitude/longitude extraction
- Firebase Realtime Database write with structured nested data (coordinates, subjects map, class map)
- Form validation with regex patterns for email, phone, pincode
- Image upload via camera or gallery with `ImagePicker` and `ImageCropper`

##  Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter (Dart) |
| **Backend** | Firebase Realtime Database |
| **Authentication** | Firebase Core |
| **Maps** | Google Maps Flutter, Geolocator, Geocoder |
| **UI Components** | flutter_rating_bar, smooth_page_indicator, editable_image |
| **State Management** | StatefulWidget with StreamSubscription |
| **Image Handling** | image_picker, image_cropper |
| **Navigation** | Named routes + MaterialPageRoute |
| **Design** | Figma (UI/UX prototyping) |
| **Project Management** | Jira (Agile sprints) |

##  Firebase Data Schema

```
├── Teachers/
│   └── {phone_number}/
│       ├── first_name: String
│       ├── last_name: String
│       ├── email_id: String
│       ├── about: String
│       ├── fee: String
│       ├── rating: Double
│       ├── coordinates/
│       │   ├── latitude: Double
│       │   └── longitude: Double
│       ├── address/
│       │   ├── main: String
│       │   ├── area: String
│       │   ├── state: String
│       │   └── pincode: String
│       ├── subjects/
│       │   └── {subject}: String
│       ├── classes/
│       │   └── {class}: String
│       ├── mode/
│       │   └── {online|offline}: String
│       └── type/
│           └── {individual|group}: String
├── Teachers_ID/
│   └── {phone_number}: String
└── Reviews/
    └── {teacher_id}/
        └── userReviews/
            └── {user_id}: String
```

##  Getting Started

### Prerequisites
- Flutter SDK (>=2.0.0)
- Dart SDK
- Firebase project with Realtime Database enabled
- Google Maps API key
- Android Studio / Xcode

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/TuteMe.git
cd TuteMe

# Install dependencies
flutter pub get

# Add your Google Maps API key
# Android: android/app/src/main/AndroidManifest.xml
# iOS: ios/Runner/AppDelegate.swift

# Add Firebase configuration
# Place google-services.json in android/app/
# Place GoogleService-Info.plist in ios/Runner/

# Run the app
flutter run
```


##  Team

Built collaboratively as a team project at SSN College of Engineering, Chennai.

##  License

This project is for educational purposes.