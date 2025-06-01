# Changelog

## [Unreleased]

### Added
- Settings view with root folder configuration
- Gear icon button in sidebar for settings access
- Root directory matching in search results

### Changed
- Method names to PascalCase (saveBookmark → SaveBookmark, etc.)
- FileExtension and FolderEntry structs to use id field instead of name
- Extracted folder dialog into separate OpenFolderDialog method

### Removed
- Unused code comments
- directoryOnly parameter from bookmark methods
- Redundant name fields in data structures
