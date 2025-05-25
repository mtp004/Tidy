//
//  FolderEntryView.swift
//  Tidy
//
//  Created by Tri Pham on 4/5/25.
//

import Foundation
import SwiftUI

struct FolderEntry: Identifiable, Equatable {
	var id: String{path}
	let name: String
	let path: String
}

struct FolderEntryView: View {
	let entry: FolderEntry
	
	var body: some View {
		HStack {
			Image(systemName: "folder.fill")
				.font(.title2)
				.foregroundColor(.blue)
				.padding(.trailing, 4)
			
			VStack(alignment: .leading, spacing: 4) {
				Text(entry.name)
					.font(.headline)
					.lineLimit(1)
					.truncationMode(.tail)
				Text(entry.path)
					.font(.caption)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.truncationMode(.middle)
			}
		}
		.padding(10)
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

#Preview {
	FolderEntryView(entry: .init(name: "Desktop", path: "/tripham/Destkop"))
}
