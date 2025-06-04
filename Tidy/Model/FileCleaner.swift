import Foundation

struct FileCleaner {
	static func clean(entries: [String: FolderAttribute]) {
		if let url = BookmarkManager.LoadBookmark(withKey: "home"){
			BookmarkManager.StartAccessing(url: url)
			
			let fileManager = FileManager.default
			
			for (_, folderAttr) in entries {
				let folderURL = URL(fileURLWithPath: folderAttr.path)
				let fileURLs: [URL]
				
				do {
					fileURLs = try fileManager.contentsOfDirectory(
						at: folderURL,
						includingPropertiesForKeys: nil,
						options: [.skipsHiddenFiles]
					)
				} catch {
					print("Error: \(error)")
					continue
				}
				
				// Collect extensions to delete
				let extensionsToDelete: Set<String> = Set(
					folderAttr.fileCategories.values
						.filter { $0.shouldDelete }
						.flatMap { $0.extensions }
						.filter { $0.isEnabled }
						.map { $0.id }
				)

				
				for fileURL in fileURLs {
					let ext = fileURL.pathExtension.lowercased()
					if extensionsToDelete.contains(ext) {
						var trashedURL: NSURL?
						do {
							try fileManager.trashItem(at: fileURL, resultingItemURL: &trashedURL)
						} catch {
							print("Failed to trash \(fileURL.path): \(error)")
						}
					}
				}
			}
			
			BookmarkManager.StopAccessing(url: url)
		}
	}
}

