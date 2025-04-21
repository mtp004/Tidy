import SwiftUI

struct ContentView: View {
	@State private var folderName: String = ""
	@State public var searchResults: [FolderEntry] = []
	@State public var isSearching: Bool = false
	private let searchManager = MetadataSearchManager()  // Instance of search manager
	
	var body: some View {
		VStack(spacing: 5) {
			HStack {
				TextField("Enter folder name here", text: $folderName)
					.padding(5)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(minWidth: 150)
					.onChange(of: folderName) { oldValue, newValue in
						if newValue.isEmpty {
							searchResults = []
						}
					}
				
				Button("Search") {
					performSearch()
				}
				.disabled(folderName.isEmpty)
				
				Spacer()
			}
			
			FolderSearchResultsView(searchResults: $searchResults, isSearching: $isSearching)
			
			Spacer()
		}
		.frame(minWidth: 300, minHeight: 200)
		.padding(5)
	}
	
	private func performSearch() {
		// Get the user's home directory
		isSearching = true
		let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
		// Perform the search in the Desktop directory
		searchManager.searchForFolders(inDirectory: homeDirectory, matching: folderName) { results in
			DispatchQueue.main.async {
				if !results.isEmpty {
					
					searchResults = results
				}
				isSearching = false
			}
		}
	}
}

#Preview {
	ContentView()
}

