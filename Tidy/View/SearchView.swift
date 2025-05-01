import SwiftUI

struct SearchView: View {
	@State private var searchURL: URL? = nil
	@State private var folderName: String = ""
	@State private var isSearching: Bool = false
	@State private var showPopover = false
	
	//Search options toggle variable
	@State private var caseSensitive: Bool = false
	@State private var exactMatch: Bool = false
	@StateObject private var searchManager = MetadataSearchManager()
	
	@State private var debounceSearchWorkItem: DispatchWorkItem?
	
	var body: some View {
		VStack(spacing: 5) {
			HStack(spacing: 5){
				
				Button(action: {
					showPopover.toggle()
				}) {
					HStack(spacing: 2){
						Image(systemName: "gearshape")
						Image(systemName: "chevron.down")
					}
					.frame(width: 25, height: 30)
				}
				.popover(isPresented: $showPopover, arrowEdge: .bottom) {
					VStack(alignment: .leading, spacing: 10) {
						Toggle("Case sensitive", isOn: $caseSensitive)
						Toggle("Exact match", isOn: $exactMatch)
					}
					.padding(10)
				}
				
				HStack {
					Image(systemName: "magnifyingglass")
						.foregroundColor(.gray)
					TextField("Enter folder name here", text: $folderName)
					
						.textFieldStyle(PlainTextFieldStyle())
						.onChange(of: folderName) { oldValue, newValue in
							debounceSearch(for: newValue)
						}
					Spacer()
				}
				.padding(8)
				.overlay(
					RoundedRectangle(cornerRadius: 10)
						.stroke(Color.cyan.opacity(0.4), lineWidth: 3)
				)
				.frame(minWidth: 150)
			}
			.padding(.vertical, 5)
			.padding(.horizontal, 10)
			.frame(maxWidth: .infinity)
			.background(Color.gray.opacity(0.2))
			.overlay(
				Rectangle()
					.stroke(Color.gray.opacity(0.4), lineWidth: 1)
			)
			
			FolderSearchResultsView(searchResults: $searchManager.searchResult, isSearching: $isSearching)
			
			Spacer()
		}
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

