# Changelog

## [Unreleased] - 2025-05-20

### Added
- Added a Home button with a house icon to ContentView for switching to a home view.
- Introduced a new ViewState case .home to manage current view states.
- Added a PanelView() method in ContentView using @ViewBuilder to cleanly switch views.
- Enabled selectedFolder binding passing through ContentView, SearchView, and FolderSearchResultsView to track folder selections across views.

### Changed
- Changed initial currentView state in ContentView from .none to .home.
- Refactored the ContentView body to replace if statement with a switch inside PanelView() for better readability and performance.
- Removed unused import Cocoa in MetadataSearchManager.swift.
- Simplified predicate string operator assignment in MetadataSearchManager.swift.
- Updated FolderSearchResultsView to use a binding selectedFolder: Set<String> instead of a local state to allow external state management.
- Updated SearchView to accept @Binding selectedFolder and pass it to FolderSearchResultsView.
- Changed the home directory usage in SearchView’s performSearch() to use the dynamic searchURL instead of a hardcoded home directory.

### Fixed
- Fixed the issue with passing the selected folder state properly through views.
- Fixed preview providers to pass realistic example data (e.g., selectedFolder: [/Users/tripham/Desktop]).

