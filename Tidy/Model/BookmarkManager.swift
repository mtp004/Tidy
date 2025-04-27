import Foundation
import Cocoa

struct BookmarkManager {
	// Key for storing bookmarks in UserDefaults
	private static let bookmarksKey = "SecurityScopedBookmarks"
	
	private static var homeDirectoryURL: URL? {
		let pw = getpwuid(getuid())
		if let homePath = pw?.pointee.pw_dir {
			let homePathString = String(cString: homePath)
			return URL(fileURLWithPath: homePathString)
		}
		return nil
	}
	
	static func saveBookmark(for url: URL, withKey key: String) -> Bool {
		do {
			// Create the bookmark data
			let bookmarkData = try url.bookmarkData(options: .withSecurityScope,
													includingResourceValuesForKeys: nil,
													relativeTo: nil)
			
			// Save in UserDefaults
			var bookmarks = UserDefaults.standard.dictionary(forKey: bookmarksKey) as? [String: Data] ?? [:]
			bookmarks[key] = bookmarkData
			UserDefaults.standard.set(bookmarks, forKey: bookmarksKey)
			
			return true
		} catch {
			print("Failed to create bookmark for \(url): \(error)")
			return false
		}
	}
	
	static func loadBookmark(withKey key: String, message: String? = nil, directoryOnly: Bool = true) -> URL? {
		// Try to load existing bookmark
		if let bookmarks = UserDefaults.standard.dictionary(forKey: bookmarksKey) as? [String: Data],
		   let bookmarkData = bookmarks[key] {
			
			do {
				var isStale = false
				let url = try URL(resolvingBookmarkData: bookmarkData,
								  options: .withSecurityScope,
								  relativeTo: nil,
								  bookmarkDataIsStale: &isStale)
				
				if isStale {
					// Bookmark needs to be recreated
					_ = saveBookmark(for: url, withKey: key)
				}
				
				return url
			} catch {
				print("Failed to resolve bookmark for key \(key): \(error)")
				// Fall through to file picker
			}
		}
		
		// No bookmark found or failed to resolve, show file picker
		let panel = NSOpenPanel()
		panel.canChooseDirectories = directoryOnly
		panel.canChooseFiles = !directoryOnly
		panel.allowsMultipleSelection = false
		panel.message = message ?? "Please select a location"
		panel.directoryURL = homeDirectoryURL
		
		let response = panel.runModal()
		
		if response == .OK, let url = panel.url {
			// Save bookmark for future use
			_ = saveBookmark(for: url, withKey: key)
			return url
		}
		
		return nil
	}
	
	@discardableResult
	static func startAccessing(url: URL) -> Bool {
		return url.startAccessingSecurityScopedResource()
	}
	
	static func stopAccessing(url: URL) {
		url.stopAccessingSecurityScopedResource()
	}
}
