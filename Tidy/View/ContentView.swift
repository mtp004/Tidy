import SwiftUI

struct ContentView: View {
	@State private var folderName: String = ""
	@State private var isSearching: Bool = false
	@StateObject private var searchManager = MetadataSearchManager()  // Instance of search manager
	
	var body: some View {
		VStack(spacing: 5) {
			HStack {
				TextField("Enter folder name here", text: $folderName)
					.padding(5)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(minWidth: 150)
					.onChange(of: folderName) { oldValue, newValue in
						if newValue.isEmpty {
							searchManager.searchResult = []
						}
					}
				
				Button("Search") {
					performSearch()
				}
				.disabled(folderName.isEmpty)
				
				Spacer()
			}
			
			FolderSearchResultsView(searchResults: $searchManager.searchResult, isSearching: $isSearching)
			
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
		searchManager.searchForFolders(inDirectory: homeDirectory, matching: folderName) {_ in 
			DispatchQueue.main.async {
				isSearching = false
			}
		}
	}
}

#Preview {
	ContentView()
}

