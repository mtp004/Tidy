# Changelog

## [2025-04-26]

### Added
- Created  to manage security-scoped bookmarks.
  - Saves and loads bookmarks using .
  - Shows  when a saved bookmark is missing or invalid.
  - Handles access to security-scoped resources with  and .

### Changed
- Modified  to use  as the main view instead of .

### Updated
- Updated :
  - Added a  state property.
  - On entering the search view (), automatically load and access the saved bookmark.
  - On exiting the search view (), properly stop accessing the bookmark.
  - Improved layout to add a spacer between the sidebar and the main content area.

