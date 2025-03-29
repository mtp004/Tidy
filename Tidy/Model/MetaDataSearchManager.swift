import Foundation
import Cocoa

// This class handles all NSMetadataQuery operations
class MetadataSearchManager {
	// The NSMetadataQuery object that performs searches
	private var metadataQuery: NSMetadataQuery?
	
	// Optional completion handler that will be called when search finishes
	private var completionHandler: ((_ results: [String]) -> Void)?
	
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
	func searchForFolders(inDirectory directory: URL, matching searchString: String, completion: @escaping ([String]) -> Void) {
		// Store the completion handler to call later
		self.completionHandler = completion
		
		// Stop any previous search
		if metadataQuery?.isStarted == true {
			metadataQuery?.stop()
		}
		
		// Configure the search scope (where to look)
		metadataQuery?.searchScopes = [directory.path]
		
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
	private func processResults(from query: NSMetadataQuery) -> [String] {
		// Temporarily pause updates while processing
		query.disableUpdates()
		
		var results: [String] = []
		
		// Process each result
		let resultCount = query.resultCount
		for i in 0..<resultCount {
			if let item = query.result(at: i) as? NSMetadataItem {
				if let path = item.value(forAttribute: NSMetadataItemPathKey) as? String,
				   let name = item.value(forAttribute: NSMetadataItemDisplayNameKey) as? String {
					// Format the result as a string
					let resultText = "• \(name)\n  Path: \(path)"
					results.append(resultText)
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
