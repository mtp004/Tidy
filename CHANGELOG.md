Changelog
Version X.X.X – 2025-04-23

Instant Search with Typing
Removed the Search button. Search now triggers automatically as the user types, thanks to a debounced input handler—streamlining the experience and reducing friction.
Debounced Search Input
Added a 250ms debounce to the search field, reducing unnecessary file system queries and ensuring responsive performance as the user types.
UI Performance Boost with LazyVStack
Switched from VStack to LazyVStack for displaying folder results. This cuts rendering cost significantly when handling large datasets.
Total Search Performance: ~30× Faster
With a previous ~10× boost and now an additional ~3× from layout optimization, the end-to-end folder search is approximately 30× faster overall.
