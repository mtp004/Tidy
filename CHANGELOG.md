# Changelog

## [Unreleased]

### Refactor
- Moved responsibility for storing search results from  to :
  - Added  to .
  -  is now updated directly within , replacing the previous pattern of returning results to the view.

### Changed
- Made  conform to  to support publishing search results.
- In , replaced the  with  to observe .
- Updated binding to  to use  instead of .
- Adjusted  call in  to ignore the results returned via completion, since results are now managed internally.
- Reset  to an empty array before each new search to ensure fresh results.

### Other
- Temporarily excluded results from  in  to avoid clutter. (Marked with a  comment for future improvement.)

