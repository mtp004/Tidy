//
//  FolderSearchResultsView.swift
//  Tidy
//
//  Created by Tri Pham on 4/18/25.
//

import SwiftUI

struct FolderSearchResultsView: View {
	@Binding var searchResults: [FolderEntry]
	@Binding var isSearching: Bool
	@State private var selectedFolder: Set<String>
	@Binding var selectedFolderEntry: [FolderEntry]
	
	// Custom initializer
	init(searchResults: Binding<[FolderEntry]>, isSearching: Binding<Bool>, selectedFolderEntry: Binding<[FolderEntry]>) {
		self._searchResults = searchResults
		self._isSearching = isSearching
		self._selectedFolderEntry = selectedFolderEntry
		
		// Initialize selectedFolder set from selectedFolderEntry paths
		let initialSelectedPaths = Set(selectedFolderEntry.wrappedValue.map { $0.path })
		self._selectedFolder = State(initialValue: initialSelectedPaths)
	}
	
	var body: some View {
		if isSearching {
			Text("Searching for results...")
				.foregroundColor(.gray)
		} else if searchResults.isEmpty {
			Text("Results will display here")
				.foregroundColor(.gray)
		} else {
			ScrollView {
				LazyVStack(alignment: .leading, spacing: 0) {
					ForEach(Array(searchResults.enumerated()), id: \.element.path) { index, item in
						let rowBackground = Color(index % 2 == 0
												  ? NSColor.windowBackgroundColor
												  : NSColor.alternatingContentBackgroundColors[1])
						HStack {
							Toggle(isOn: Binding<Bool>(
								get: { selectedFolder.contains(item.path) },
								set: { isChecked in
									if isChecked {
										selectedFolder.insert(item.path)
										if !selectedFolderEntry.contains(where: { $0.path == item.path }) {
											selectedFolderEntry.append(item)
										}
									} else {
										selectedFolder.remove(item.path)
										selectedFolderEntry.removeAll { $0.path == item.path }
									}
								}
							)) {
								EmptyView()
							}
							.labelsHidden()
							.padding(.leading, 8)
							
							FolderEntryView(entry: item)
						}
						.background(rowBackground)
						.cornerRadius(4)
					}
				}
			}
			.background(Color(NSColor.controlBackgroundColor))
			.clipShape(RoundedRectangle(cornerRadius: 8))
			.padding(5)
		}
	}
}

#Preview {
	FolderSearchResultsView(searchResults: .constant([]), isSearching: .constant(false), selectedFolderEntry: .constant([]))
}


