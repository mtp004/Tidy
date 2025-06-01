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
	
	@Binding var selectedEntry: [String: FolderAttribute]
	
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
							.onChange(of: caseSensitive) { oldValue, newValue in
								searchManager.UpdateNSPredicate(caseSensitive: caseSensitive, exactMatch: exactMatch)
							}
						Toggle("Exact match", isOn: $exactMatch)
							.onChange(of: exactMatch) { oldValue, newValue in
								searchManager.UpdateNSPredicate(caseSensitive: caseSensitive, exactMatch: exactMatch)
							}
					}
					.padding(10)
				}
				
				HStack {
					Image(systemName: "magnifyingglass")
						.foregroundColor(.gray)
					TextField("Enter folder name here", text: $folderName)
					
						.textFieldStyle(PlainTextFieldStyle())
						.onChange(of: folderName) { oldValue, newValue in
							DebounceSearch(for: newValue)
						}
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
			.background(Color.gray.opacity(0.2))
			.overlay(
				Rectangle()
					.stroke(Color.gray.opacity(0.4), lineWidth: 1)
			)
			
			FolderSearchResultsView(searchResults: $searchManager.searchResult, isSearching: $isSearching, selectedEntry: $selectedEntry)
			
			Spacer()
		}
		.onAppear(){
			searchURL = BookmarkManager.LoadBookmark(withKey: "home")
			if let searchURL{
				BookmarkManager.StartAccessing(url: searchURL)
				searchManager.UpdateSearchURL(url: searchURL)
			}
		}
		.onDisappear(){
			if let searchURL{
				BookmarkManager.StopAccessing(url: searchURL)
			}
		}
	}
	
	private func DebounceSearch(for input: String) {
		// Cancel previous work
		debounceSearchWorkItem?.cancel()
		
		if input.isEmpty {
			searchManager.searchResult.removeAll()
			return
		}
		
		// Schedule new debounced search
		let workItem = DispatchWorkItem {
			PerformSearch() }
		debounceSearchWorkItem = workItem
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: workItem)
	}
	
	private func PerformSearch() {
		isSearching = true
		guard let searchURL = searchURL else {
			isSearching = false
			return
		}
		searchManager.SearchForFolders(inDirectory: searchURL, matching: folderName) { _ in
			DispatchQueue.main.async {
				isSearching = false
			}
		}
		
		//logic for edge case handling the root directory here
		let targetName = searchURL.lastPathComponent
		let isMatch: Bool

		if exactMatch {
			isMatch = caseSensitive
				? (targetName == folderName)
				: (targetName.lowercased() == folderName.lowercased())
		} else {
			isMatch = caseSensitive
				? targetName.contains(folderName)
				: targetName.lowercased().contains(folderName.lowercased())
		}

		if isMatch {
			searchManager.searchResult.append(FolderEntry(id: targetName, path: searchURL.path))
		}
	}
}

#Preview {
	// Create FolderAttribute instances
	let desktopAttr = FolderAttribute(name: "Desktop", path: "/Users/tripham/Desktop")
	let downloadsAttr = FolderAttribute(name: "Downloads", path: "/Users/tripham/Downloads")
	let projectXAttr = FolderAttribute(name: "ProjectX", path: "/Users/tripham/Documents/ProjectX")

	return SearchView(selectedEntry: .constant([
		"/Users/tripham/Desktop": desktopAttr,
		"/Users/tripham/Downloads": downloadsAttr,
		"/Users/tripham/Documents/ProjectX": projectXAttr
	]))
}
