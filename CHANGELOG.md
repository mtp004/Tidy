# Changelog

## [Unreleased]

### Added
- Settings view with root folder configuration
- Gear icon button in sidebar for settings access
- Root directory matching in search results

### Changed
- Method names to PascalCase ( → , etc.)
-  and  structs to use uid=501(tripham) gid=20(staff) groups=20(staff),12(everyone),61(localaccounts),79(_appserverusr),80(admin),81(_appserveradm),98(_lpadmin),701(com.apple.sharepoint.group.1),33(_appstore),100(_lpoperator),204(_developer),250(_analyticsusers),395(com.apple.access_ftp),398(com.apple.access_screensharing),399(com.apple.access_ssh),400(com.apple.access_remote_ae) field instead of 
- Extracted folder dialog into separate  method

### Removed
- Unused code comments
-  parameter from bookmark methods
- Redundant  fields in data structures
