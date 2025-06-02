import SwiftUI

struct SettingsView: View {
	@State private var path: URL? = nil
	private let key: String = "home"
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Root Folder")
				.font(.title2)
				.bold()
			
			HStack(spacing: 10) {
				Button(action: {
					path = BookmarkManager.OpenFolderDialog(withKey: key, message: "Please select a new root folder")
				}) {
					Image(systemName: "folder.fill")
						.imageScale(.medium)
						
						.background(Color.accentColor.opacity(0.1))
						.clipShape(RoundedRectangle(cornerRadius: 5))
				}
				
				Divider()
					.frame(height: 20)
					.background(Color.gray.opacity(0.5))
				
				Text(path?.path() ?? "No folder selected")
					.font(.callout)
					.foregroundColor(.secondary)
					.lineLimit(1)
					.truncationMode(.middle)
				
				Spacer()
			}
			.padding(5)
			.background(Color(NSColor.controlBackgroundColor))
			.overlay(
				RoundedRectangle(cornerRadius: 5)
					.stroke(Color.gray.opacity(0.4), lineWidth: 2)
			)
		}
		.padding(10)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.onAppear {
			path = BookmarkManager.LoadBookmark(withKey: key)
		}
	}
}

#Preview {
	SettingsView()
}

