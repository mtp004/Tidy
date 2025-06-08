# Tidy - macOS File Cleanup App

A simple and intuitive macOS application for cleaning up files in your folders by organizing and deleting files based on their types (images, documents, videos).

## Getting Started

### 1. Initial Setup

When you first launch Tidy, you'll need to set up your root folder:

1. Click the **Settings** tab (gear icon) in the sidebar
2. Click the folder icon next to "Root Folder"
3. Select the directory you want to search within (e.g., your home folder)

### 2. Finding Folders to Clean

1. Click the **Search** tab (magnifying glass icon) in the sidebar
2. Use the search field to find folders by name
3. Configure search options using the gear icon:
   - **Case sensitive**: Match exact capitalization
   - **Exact match**: Find folders with exact name matches only
4. Select folders from the search results by checking the boxes

### 3. Configuring File Types

For each selected folder, you can configure which file types to delete:

#### Image Files
- **Supported formats**: JPG, JPEG, PNG, GIF, BMP, TIFF, HEIC
- Click the photo icon to toggle deletion of image files
- Click the dropdown arrow to customize which image formats to include

#### Document Files
- **Supported formats**: PDF, DOC, DOCX, TXT, RTF, XLS, XLSX, PPT, PPTX
- Click the document icon to toggle deletion of document files
- Click the dropdown arrow to customize which document formats to include

#### Video Files
- **Supported formats**: MP4, MOV, AVI, MKV, FLV, WMV, WEBM
- Click the video icon to toggle deletion of video files
- Click the dropdown arrow to customize which video formats to include

### 4. Managing Selected Folders

1. Click the **Home** tab (house icon) to view your selected folders
2. Review your selections and file type configurations
3. Remove folders by clicking the red X button if needed

### 5. Cleaning Files

⚠️ **Important**: Files will be moved to Trash, not permanently deleted.

1. In the Home tab, locate the red "Delete" button
2. **Hold down** the Delete button for 1.5 seconds
3. The button will fill with a progress indicator
4. Release when complete to execute the cleanup
5. A success message will confirm the operation

## Permissions

The app requires the following macOS permissions:
- **Files and Folders**: To access and modify your selected directories
- **Pictures**: To handle image files
- **Movies**: To handle video files
- **Music**: To handle audio-related media files
- **Downloads**: To access the Downloads folder
