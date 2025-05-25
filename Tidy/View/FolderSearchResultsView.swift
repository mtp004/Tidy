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
	@Binding var selectedEntry: [String: FolderAttribute]
	
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
								get: {
									selectedEntry[item.path] != nil
								},
								set: { isChecked in
									if isChecked {
										let attribute = FolderAttribute(name: item.name, path: item.path)
										selectedEntry[item.path] = attribute
									} else {
										selectedEntry.removeValue(forKey: item.path)
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
	FolderSearchResultsView(
		searchResults: .constant([
			FolderEntry(name: "Desktop", path: "/Users/tripham/Desktop"),
			FolderEntry(name: "Downloads", path: "/Users/tripham/Downloads"),
			FolderEntry(name: "ProjectX", path: "/Users/tripham/Documents/ProjectX")
		]),
		isSearching: .constant(false),
		selectedEntry: .constant([
			"/Users/tripham/Desktop": FolderAttribute(name: "Desktop", path: "/Users/tripham/Desktop", deleteImage: true),
			"/Users/tripham/Documents/ProjectX": FolderAttribute(name: "ProjectX", path: "/Users/tripham/Documents/ProjectX", deleteDocument: true)
		])
	)
}



