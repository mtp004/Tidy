# Changelog

## [Unreleased]

### Changed
- **Tidy.xcodeproj/project.pbxproj**
  - Changed the  to Apple Development for macOS SDK.
  - Added the  key for the team ID (5FSYX2QT8A).
  
- **Tidy/Tidy.entitlements**
  - Added app sandbox entitlement to allow access to read and write assets such as movies, music, pictures, and user-selected files.
  
- **Tidy/TidyApp.swift**
  - Changed the root view from  to .
  
- **Tidy/View/ContentView.swift**
  - Removed unused states and search logic.
  - Implemented  enum to manage the view displayed on the right side (either  or ).
  - Added a button to toggle the right view between none and search.
  - Removed previous folder search view and integrated search functionality directly into .

- **Tidy/View/SearchView.swift**
  - New file:  is now a separate view that contains the folder search UI.
  - Implemented debounced search functionality.
  - Integrated  to display search results.

### Added
- **SearchView**: A new SwiftUI view that handles folder name input and displays search results for folders.

### Removed
- Removed old folder search UI and logic from , and refactored the search functionality into the new .


