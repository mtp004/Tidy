import Foundation
import Cocoa

// This class handles all NSMetadataQuery operations
class MetadataSearchManager {
	// The NSMetadataQuery object that performs searches
	private var metadataQuery: NSMetadataQuery?
	
	// Optional completion handler that will be called when search finishes
	private var completionHandler: ((_ results: [FolderEntry]) -> Void)?
	
	// Initialize the manager
	init() {
		setupMetadataQuery()
	}
	
	// Set up the metadata query and its notification observers
	private func setupMetadataQuery() {
		metadataQuery = NSMetadataQuery()
		
		// Register for the notification that tells us when search is complete
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(queryDidFinishGathering(_:)),
			name: NSNotification.Name.NSMetadataQueryDidFinishGathering,
			object: metadataQuery
		)
	}
	
	// Search for folders in a specific directory that match a search string
	func searchForFolders(inDirectory directory: URL, matching searchString: String, completion: @escaping ([FolderEntry]) -> Void) {
		// Store the completion handler to call later
		self.completionHandler = completion
		
		// Stop any previous search
		if metadataQuery?.isStarted == true {
			metadataQuery?.stop()
		}
		
		// Get all non-hidden subdirectories
		let searchPaths = getAllNonHiddenSubdirectories(of: directory)
		
		print("Searching in \(searchPaths.count) directories")
		
		// Configure the search scope with all subdirectories
		metadataQuery?.searchScopes = searchPaths
		
		// Set up the search criteria using NSPredicate
		let predicate = NSPredicate(format: "kMDItemContentTypeTree == 'public.folder' AND kMDItemDisplayName CONTAINS[cd] %@", searchString)
		metadataQuery?.predicate = predicate
		
		// Specify which attributes we want to retrieve
		metadataQuery?.valueListAttributes = [
			NSMetadataItemPathKey,
			NSMetadataItemDisplayNameKey
		]
		
		// Start the search
		metadataQuery?.start()
	}

	// Helper function to get all non-hidden subdirectories
	private func getAllNonHiddenSubdirectories(of directory: URL) -> [String] {
		let fileManager = FileManager.default
		var directoryPaths = [directory.path] // Include the starting directory itself
		
		do {
			// Get all items in the directory, skipping hidden files
			let contents = try fileManager.contentsOfDirectory(at: directory,
														   includingPropertiesForKeys: [.isDirectoryKey],
														   options: [.skipsHiddenFiles])
			
			// Filter to only include directories
			for url in contents {
				var isDirectory: ObjCBool = false
				if fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue {
					directoryPaths.append(url.path)
				}
			}
			
		} catch {
			print("Error getting subdirectories: \(error)")
		}
		
		return directoryPaths
	}
	
	// This method is called when the search completes
	@objc private func queryDidFinishGathering(_ notification: Notification) {
		guard let query = notification.object as? NSMetadataQuery else { return }
		
		// Process the search results
		let results = processResults(from: query)
		
		// Call the completion handler on the main thread
		DispatchQueue.main.async {
			self.completionHandler?(results)
		}
		
		// Stop the query since we're done
		query.stop()
	}
	
	// Process the search results into a usable format
	private func processResults(from query: NSMetadataQuery) -> [FolderEntry] {
		// Temporarily pause updates while processing
		query.disableUpdates()
		
		var results: [FolderEntry] = []
		
		// Process each result
		let resultCount = query.resultCount
		for i in 0..<resultCount {
			if let item = query.result(at: i) as? NSMetadataItem {
				if let path = item.value(forAttribute: NSMetadataItemPathKey) as? String,
				   let name = item.value(forAttribute: NSMetadataItemDisplayNameKey) as? String {
					results.append(FolderEntry(name: name, path: path))
				}
			}
		}
		
		// Re-enable updates
		query.enableUpdates()
		return results
	}
	
	// Clean up resources
	deinit {
		if metadataQuery?.isStarted == true {
			metadataQuery?.stop()
		}
		NotificationCenter.default.removeObserver(self)
	}
}
