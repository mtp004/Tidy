//
//  MainMenuView.swift
//  Tidy
//
//  Created by Tri Pham on 5/21/25.
//

import SwiftUI

struct MainMenuView: View {
	@Binding var selectedFolder: Set<String>
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Selected Folders:")
				.font(.headline)
			
			if selectedFolder.isEmpty {
				Text("No folders selected.")
					.foregroundColor(.gray)
			} else {
				ScrollView {
					VStack(alignment: .leading, spacing: 8) {
						ForEach(Array(selectedFolder), id: \.self) { path in
							Text(path)
								.font(.body)
								.lineLimit(1)
								.truncationMode(.middle)
						}
					}
				}
				.frame(maxHeight: 200) // limit height of scroll view
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding()
	}
}

#Preview {
	MainMenuView(selectedFolder: .constant([
		"/Users/tripham/Desktop",
		"/Users/tripham/Documents/ProjectX",
		"/Users/tripham/Downloads"
	]))
}
