//
//  FolderEntryView.swift
//  Tidy
//
//  Created by Tri Pham on 4/5/25.
//

import Foundation
import SwiftUI

struct FolderEntry: Identifiable {
	var id: String{path}
	let name: String
	let path: String
}

struct FolderEntryView: View {
	let entry: FolderEntry
	
	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(entry.name)
					.font(.headline)
				Text(entry.path)
					.font(.caption)
					.foregroundColor(.secondary)
					.truncationMode(.middle)
			}
			Spacer() // Pushes content to the left
		}
		.padding()
		.background(
			RoundedRectangle(cornerRadius: 12)
				.fill(Color(NSColor.windowBackgroundColor))
				.shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
		)
		.frame(maxWidth: .infinity)
	}
}

#Preview {
	FolderEntryView(entry: .init(name: "Desktop", path: "/tripham/Destkop"))
}
