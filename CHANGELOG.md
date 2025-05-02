# Changelog

## [Unreleased] - 2025-05-02

### Added
- Added case-sensitive and exact match search functionality
  - Added  and  properties to  class
  - Created new  function to generate appropriate search predicates based on search preferences
  - Connected UI toggles to the search manager via onChange handlers

### Changed
- Modified search predicate generation in  to use the new configurable  function
- Updated search query to respect user preferences for case sensitivity and exact matching

### Technical Details
- Added support for different NSPredicate operators:
  - Case-sensitive exact match: 
  - Case-insensitive exact match: 
  - Case-sensitive partial match: 
  - Case-insensitive partial match: 
- Added SwiftUI import to MetaDataSearchManager.swift to support @Published properties
