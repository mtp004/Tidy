# Changelog

## [Unreleased]

### Added
- Created  to modularize display of folder search results.
- Added system folder icons to each search result row for improved UI clarity.
- Introduced  state to show progress status during metadata queries.
- Implemented logic to exclude  folder from search results using path prefix filtering in .

### Changed
- Replaced inline folder rendering logic in  with  for better separation of concerns.
- Adjusted vertical spacing in  from 10 to 5 for a more compact layout.
- Made  and  public to enable two-way binding with the results view.

### Improved
- Enhanced layout in :
  - Added leading folder icon () for each result row.
  - Enabled text truncation and line limit for long folder names.
  - Introduced alternating row backgrounds for better visual separation.
- Improved metadata filtering logic to skip  when searching from the home directory.
- Better user feedback during search:
  - Searching for results… appears while search is in progress.
  - Clearer empty state message when no results are available.

---

_This changelog was generated based on changes staged in Git as of April 20, 2025._

