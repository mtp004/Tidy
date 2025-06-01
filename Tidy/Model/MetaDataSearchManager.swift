import Foundation
import SwiftUI


// This class handles all NSMetadataQuery operations
class MetadataSearchManager: ObservableObject {
	private var predicateString: String = "kMDItemContentTypeTree == 'public.folder' AND kMDItemDisplayName CONTAINS[cd] %@"
	private var metadataQuery: NSMetadataQuery?
	// Optional completion handler that will be called when search finishes
	private var completionHandler: ((_ results: [FolderEntry]) -> Void)?
	@Published public var searchResult: [FolderEntry] = [FolderEntry]()
	private var searchScope: [URL] = [URL]()
	private var excludeScope: [URL] = [URL]()
	
	init(){
		SetupExcludedScope()
		SetupMetadataQuery()
	}
	
	func UpdateNSPredicate(caseSensitive: Bool, exactMatch: Bool){
		let operatorString: String

		if exactMatch {
			// Exact match
			operatorString = caseSensitive ? "==" : "==[cd]"
		} else {
			// Partial match
			operatorString = caseSensitive ? "CONTAINS" : "CONTAINS[cd]"
		}

		predicateString = "kMDItemContentTypeTree == 'public.folder' AND kMDItemDisplayName \(operatorString) %@"
	}
	
	// Initialize the manager
	func UpdateSearchURL(url: URL?){
		if let searchURL = url {
			UpdateSearchScope(from: searchURL)
		} else{
			searchScope.removeAll()
		}
	}
	
	
	private func shouldExcludeDirectory(_ directory: URL) -> Bool {
		// Check if the directory is in our exclude list
		return excludeScope.contains { directory.path.hasPrefix($0.path) }
	}
	
	// Set up the metadata query and its notification observers
	private func SetupMetadataQuery() {
		metadataQuery = NSMetadataQuery()
		
		// Register for the notification that tells us when search is complete
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(queryDidFinishGathering(_:)),
			name: NSNotification.Name.NSMetadataQueryDidFinishGathering,
			object: metadataQuery
		)
	}
	
	// Set up the default scope to be excluded, only use if not provided a custom excluded scope
	private func SetupExcludedScope() {
		if let homeDir = BookmarkManager.homeDirectoryURL{
			// Common directories to exclude
			excludeScope = [
				homeDir.appendingPathComponent("iCloud Drive (Archive)")
			]
		}
	}
	// Search for folders in a specific directory that match a search string
	func SearchForFolders(inDirectory directory: URL, matching searchString: String, completion: @escaping ([FolderEntry]) -> Void) {
		// Stop any previous search
		if metadataQuery?.isStarted == true {
			metadataQuery?.stop()
		}
		// Store the completion handler to call later
		self.completionHandler = completion
		self.searchResult.removeAll()
		
		if !searchString.isEmpty {
			for url in searchScope {
				let directoryName = url.lastPathComponent
				if directoryName.localizedCaseInsensitiveContains(searchString) {
					searchResult.append(FolderEntry(id: directoryName, path: url.path))
				}
			}
		}
		
		// Configure the search scope with all subdirectories
		metadataQuery?.searchScopes = searchScope
		
		// Set up the search criteria using NSPredicate
		metadataQuery?.predicate = NSPredicate(format: predicateString, searchString)
		
		// Specify which attributes we want to retrieve
		metadataQuery?.valueListAttributes = [
			NSMetadataItemPathKey,
			NSMetadataItemDisplayNameKey
		]
		
		// Start the search
		metadataQuery?.start()
	}
	
	// Helper function to get all non-hidden subdirectories
	private func UpdateSearchScope(from directory: URL) {
		let fileManager = FileManager.default
		
		// Clear existing entries
		searchScope.removeAll()
		
		do {
			// Get all items in the directory, skipping hidden files
			let contents = try fileManager.contentsOfDirectory(at: directory,
															   includingPropertiesForKeys: [.isDirectoryKey],
															   options: [.skipsHiddenFiles])
			
			// Filter to only include directories
			for url in contents {
				var isDirectory: ObjCBool = false
				if fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue {
					// Skip Library directory in home folder
					if shouldExcludeDirectory(url) {
						continue
					}
					searchScope.append(url)
				}
			}
		} catch {
			print("Error getting subdirectories: \(error)")
		}
	}
	
	@objc private func queryDidFinishGathering(_ notification: Notification) {
		guard let query = notification.object as? NSMetadataQuery else { return }
		
		// Process the search results
		ProcessResults(from: query)
		
		// Call the completion handler on the main thread
		DispatchQueue.main.async {
			self.completionHandler?(self.searchResult)
		}
		
		// Stop the query since we're done
		query.stop()
	}
	
	// Process the search results into a usable format
	private func ProcessResults(from query: NSMetadataQuery) -> Void{
		// Process each result
		let resultCount = query.resultCount
		for i in 0..<resultCount {
			if let item = query.result(at: i) as? NSMetadataItem {
				if let path = item.value(forAttribute: NSMetadataItemPathKey) as? String,
				   let name = item.value(forAttribute: NSMetadataItemDisplayNameKey) as? String {
					searchResult.append(FolderEntry(id: name, path: path))
				}
			}
		}
	}
	
	// Clean up resources
	deinit {
		if metadataQuery?.isStarted == true {
			metadataQuery?.stop()
		}
		NotificationCenter.default.removeObserver(self)
	}
}
