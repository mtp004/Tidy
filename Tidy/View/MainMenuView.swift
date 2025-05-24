//
//  MainMenuView.swift
//  Tidy
//
//  Created by Tri Pham on 5/21/25.
//

import SwiftUI

struct MainMenuView: View {
	@Binding var selectedFolderEntry: [FolderEntry]

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Selected Folders:")
				.font(.headline)

			if selectedFolderEntry.isEmpty {
				Text("No folders selected.")
					.foregroundColor(.gray)
			} else {
				ScrollView {
					VStack(alignment: .leading, spacing: 8) {
						ForEach(selectedFolderEntry) { entry in
							HStack {
								FolderEntryView(entry: entry)
								Spacer()
								Button(action: {
									remove(entry: entry)
								}) {
									Image(systemName: "xmark.circle.fill")
										.foregroundColor(.red)
										.font(.title3)
								}
								.buttonStyle(PlainButtonStyle())
							}
							.background(Color.gray.opacity(0.05))
							.cornerRadius(8)
						}
					}
				}
				.frame(maxHeight: 200)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding()
	}

	private func remove(entry: FolderEntry) {
		selectedFolderEntry.removeAll { $0 == entry }
	}
}


#Preview {
	MainMenuView(
		selectedFolderEntry: .constant([
			FolderEntry(name: "Desktop", path: "/Users/tripham/Desktop"),
			FolderEntry(name: "ProjectX", path: "/Users/tripham/Documents/ProjectX"),
			FolderEntry(name: "Downloads", path: "/Users/tripham/Downloads")
		])
	)
}
