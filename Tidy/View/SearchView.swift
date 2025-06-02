import SwiftUI

struct SearchView: View {
	@State private var searchURL: URL?
	@State private var folderName = ""
	@State private var isSearching = false
	@State private var showPopover = false
	private let debounceDelay: Double = 0.25
	
	@State private var caseSensitive = false
	@State private var exactMatch = false
	@StateObject private var searchManager = MetadataSearchManager()
	
	@State private var debounceSearchWorkItem: DispatchWorkItem?
	
	@Binding var selectedEntry: [String: FolderAttribute]
	
	var body: some View {
		VStack(spacing: 5) {
			HStack(spacing: 5) {
				settingsButton
				searchField
			}
			.padding(.vertical, 5)
			.padding(.horizontal, 10)
			.background(Color.gray.opacity(0.2))
			.overlay(
				Rectangle()
					.stroke(Color.gray.opacity(0.4), lineWidth: 1)
			)
			
			FolderSearchResultsView(
				searchResults: $searchManager.searchResult,
				isSearching: $isSearching,
				selectedEntry: $selectedEntry
			)
			
			Spacer()
		}
		.onAppear(perform: LoadBookmark)
		.onDisappear(perform: CleanupBookmark)
	}
	
	private var settingsButton: some View {
		Button(action: { showPopover.toggle() }) {
			HStack(spacing: 2) {
				Image(systemName: "gearshape")
				Image(systemName: "chevron.down")
			}
			.frame(width: 25, height: 30)
		}
		.popover(isPresented: $showPopover, arrowEdge: .bottom) {
			VStack(alignment: .leading, spacing: 10) {
				Toggle("Case sensitive", isOn: $caseSensitive)
					.onChange(of: caseSensitive){ _, _ in
						UpdatePredicate()
					}
				Toggle("Exact match", isOn: $exactMatch)
					.onChange(of: exactMatch){ _, _ in
						UpdatePredicate()
					}
			}
			.padding(10)
		}
	}
	
	private var searchField: some View {
		HStack {
			Image(systemName: "magnifyingglass")
				.foregroundColor(.gray)
			TextField("Enter folder name here", text: $folderName)
				.textFieldStyle(PlainTextFieldStyle())
				.onChange(of: folderName){ _, _ in
					DebounceSearch(for: folderName)
				}
		}
		.padding(8)
		.overlay(
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.cyan.opacity(0.4), lineWidth: 3)
		)
		.frame(minWidth: 150)
	}
	
	private func LoadBookmark() {
		guard let url = BookmarkManager.LoadBookmark(withKey: "home") else { return }
		searchURL = url
		BookmarkManager.StartAccessing(url: url)
		searchManager.UpdateSearchURL(url: url)
	}
	
	private func CleanupBookmark() {
		guard let searchURL = searchURL else { return }
		BookmarkManager.StopAccessing(url: searchURL)
	}
	
	private func UpdatePredicate() {
		searchManager.UpdateNSPredicate(caseSensitive: caseSensitive, exactMatch: exactMatch)
	}
	
	private func DebounceSearch(for input: String) {
		debounceSearchWorkItem?.cancel()
		
		guard !input.isEmpty else {
			searchManager.searchResult.removeAll()
			return
		}
		
		let workItem = DispatchWorkItem {
			PerformSearch()
		}
		debounceSearchWorkItem = workItem
		DispatchQueue.main.asyncAfter(deadline: .now() + debounceDelay, execute: workItem)
	}
	
	private func PerformSearch() {
		guard let searchURL = searchURL else {
			isSearching = false
			return
		}
		
		isSearching = true
		
		searchManager.SearchForFolders(inDirectory: searchURL, matching: folderName) {_ in
			DispatchQueue.main.async {
				isSearching = false
			}
		}
		
		let targetName = searchURL.lastPathComponent

		let isMatch: Bool
		if caseSensitive {
			isMatch = exactMatch
				? targetName == folderName
				: targetName.contains(folderName)
		} else {
			let targetLowercased = targetName.lowercased()
			let folderLowercased = folderName.lowercased()
			isMatch = exactMatch
				? targetLowercased == folderLowercased
				: targetLowercased.contains(folderLowercased)
		}

		if isMatch {
			searchManager.searchResult.append(FolderEntry(id: targetName, path: searchURL.path))
		}

	}
}

#Preview {
	let desktopAttr = FolderAttribute(name: "Desktop", path: "/Users/tripham/Desktop")
	let downloadsAttr = FolderAttribute(name: "Downloads", path: "/Users/tripham/Downloads")
	let projectXAttr = FolderAttribute(name: "ProjectX", path: "/Users/tripham/Documents/ProjectX")
	
	return SearchView(selectedEntry: .constant([
		"/Users/tripham/Desktop": desktopAttr,
		"/Users/tripham/Downloads": downloadsAttr,
		"/Users/tripham/Documents/ProjectX": projectXAttr
	]))
}

