### Changelog for SearchView.swift
**Date:** May 1, 2025

---

**Added:**
- New state variables for popover and search options:
  - 
  - 
  - 
  
- Replaced the  with a  that toggles the visibility of a popover for search options.
- A popover view containing two  controls:
  - **Case sensitive**: Toggles case sensitivity in search.
  - **Exact match**: Toggles exact match search behavior.
- Popover is aligned to the **leading edge** with padding for better layout control.

**Removed:**
- The previous  with placeholder search options:
  - Search by Name
  - Search by Date
  - Search by Tag

**Improved:**
- Refined the layout of the search options to use a popover, allowing a cleaner user experience for configuring search behavior.

