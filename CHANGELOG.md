# Changelog

## [Unreleased]

### Changed
- **Expanded Search Scope:** `MetadataSearchManager` now includes all non-hidden subdirectories of the target directory when performing folder searches, rather than just the root directory itself.
  - Added helper method `getAllNonHiddenSubdirectories(of:)` to recursively collect search paths.
  - Replaced single-directory `searchScopes` assignment with a full list of subdirectories.

### Removed
- Removed unnecessary debug print statement from `ContentView` that printed the user's home directory.

### Fixed
- Improved search reliability by ensuring important directories like `~/Desktop` are not skipped when the user selects a higher-level folder like their Home directory.

