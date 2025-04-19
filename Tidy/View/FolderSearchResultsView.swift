//
//  FolderSearchResultsView.swift
//  Tidy
//
//  Created by Tri Pham on 4/18/25.
//

import SwiftUI

struct FolderSearchResultsView: View {
	@Binding var searchResults: [FolderEntry]
	
	var body: some View {
		if searchResults.isEmpty {
			Text("Results will display here")
				.foregroundColor(.gray)
		} else {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {
					ForEach(Array(searchResults.enumerated()), id: \.element.path) { index, entry in
						FolderEntryView(entry: entry)
							.background(index % 2 == 0 ?
										Color(NSColor.windowBackgroundColor) :
											Color(NSColor.alternatingContentBackgroundColors[1]))
							.cornerRadius(4)
					}
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)  // Limit scrollable height
			.background(Color(NSColor.controlBackgroundColor))
			.clipShape(RoundedRectangle(cornerRadius: 8))
			.padding(5)
		}
	}
}

#Preview {
	FolderSearchResultsView(searchResults: .constant([]))
}


