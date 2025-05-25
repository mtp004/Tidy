# Changelog - Tidy App

## [Unreleased] - 2025-05-25

### Added
- **New FolderAttribute Model**: Introduced  class to replace simple  arrays
 - Added support for file type deletion preferences (images, documents, videos)
 - Implemented  protocol for reactive UI updates
 - Each folder now has configurable deletion settings per file type

- **New FolderAttributeView Component**: Created dedicated view for displaying folder attributes
 - Visual folder icon and path display
 - Interactive toggle buttons for file type deletion settings
 - Color-coded buttons (red when active, gray when inactive)
 - Clean, compact layout with proper text truncation

### Changed
- **Refactored Data Structure**: Migrated from  array to  dictionary
 - Uses folder path as key for efficient lookups and duplicate prevention
 - Improved data consistency across all views

- **Updated ContentView**: 
 - Changed  binding to  with new dictionary structure
 - Updated preview data to demonstrate new folder attributes functionality

- **Enhanced MainMenuView**:
 - Redesigned to display  components instead of basic 
 - Added smooth animations for folder addition/removal
 - Improved layout with better spacing and visual hierarchy
 - Increased maximum height for folder list (200px → 300px)

- **Improved FolderSearchResultsView**:
 - Simplified toggle logic using dictionary-based selection
 - Removed complex initialization and state management
 - Cleaner folder selection/deselection with automatic  creation
 - Updated preview with realistic sample data

- **Enhanced SearchView**:
 - Updated to work with new dictionary-based folder selection
 - Added null safety check for 
 - Improved preview data with diverse folder attributes

### Removed
- **Cleaned up FolderEntryView**: Removed unused  state variable
- **Simplified Architecture**: Eliminated complex state synchronization between multiple selection arrays

### Technical Improvements
- Better memory management with dictionary-based lookups
- Reduced code complexity in selection state management
- Enhanced type safety with structured folder attributes
- Improved UI responsiveness with  integration
