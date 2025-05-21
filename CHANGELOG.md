# Tidy App Changelog

## Version [Next Release] - May 21, 2025

### Added
- Added new Info.plist file to the project
- Created new MainMenuView.swift to display selected folders
- Added PBXFileSystemSynchronizedBuildFileExceptionSet section to exclude Info.plist from synchronization
- Added alternating row background colors in the folder search results list
- Added Equatable protocol conformance to FolderEntry struct

### Changed
- Modified project configuration to use the explicit Info.plist file path
- Replaced the placeholder Home text with the new MainMenuView
- Changed window size constraints:
  - Reduced minimum width from 700px to 400px
  - Reduced minimum height to 300px
  - Removed ideal width/height constraints
- Improved FolderEntryView's layout with proper alignment
- Enhanced SearchView UI by removing unnecessary spacers
- Updated the preview path in SearchView to use a more realistic example path (/Users/tripham/Desktop)
- Added padding to checkboxes in search results for better spacing

### Fixed
- Fixed a typo in the frame property: maxHeight: .infinitys should be .infinity
- Improved UI alignment and spacing throughout the app
- Optimized layout of multiple views by removing unnecessary Spacer() elements

### UI Improvements
- Better folder entry text alignment with explicit leading alignment
- Improved search results rendering with alternating background colors
- More compact and efficient use of space in multiple views
- Cleaner search interface with optimized layout
