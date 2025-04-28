import SwiftUI

struct SearchView: View {
	@State private var searchURL: URL? = nil
	@State private var folderName: String = ""
	@State private var isSearching: Bool = false
	@StateObject private var searchManager = MetadataSearchManager()
	
	@State private var debounceSearchWorkItem: DispatchWorkItem?
	
	var body: some View {
		VStack(spacing: 5) {
			HStack {
				TextField("Enter folder name here", text: $folderName)
					.padding(5)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(minWidth: 150)
					.onChange(of: folderName) { oldValue, newValue in
						debounceSearch(for: newValue)
					}
				Spacer()
			}
			FolderSearchResultsView(searchResults: $searchManager.searchResult, isSearching: $isSearching)
			
			Spacer()
		}
		.padding(5)
		.onAppear(){
			searchURL = BookmarkManager.loadBookmark(withKey: "home")
			if let searchURL{
				BookmarkManager.startAccessing(url: searchURL)
				searchManager.UpdateSearchURL(url: searchURL)
			}
		}
		.onDisappear(){
			if let searchURL{
				BookmarkManager.stopAccessing(url: searchURL)
			}
		}
	}
	
	private func debounceSearch(for input: String) {
		// Cancel previous work
		debounceSearchWorkItem?.cancel()
		
		if input.isEmpty {
			searchManager.searchResult.removeAll()
			return
		}
		
		// Schedule new debounced search
		let workItem = DispatchWorkItem { performSearch() }
		debounceSearchWorkItem = workItem
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: workItem)
	}
	
	private func performSearch() {
		isSearching = true
		let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
		searchManager.searchForFolders(inDirectory: homeDirectory, matching: folderName) { _ in
			DispatchQueue.main.async {
				isSearching = false
			}
		}
	}
}

#Preview {
	SearchView()
}

