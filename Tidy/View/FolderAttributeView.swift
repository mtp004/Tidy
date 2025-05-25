import SwiftUI

struct FolderAttributeView: View {
	@ObservedObject var attribute: FolderAttribute

	var body: some View {
		VStack(alignment: .leading){
			HStack {
				Image(systemName: "folder.fill")
					.font(.title2)
					.foregroundColor(.blue)
					.padding(.trailing, 4)
				
				VStack(alignment: .leading, spacing: 4) {
					Text(attribute.name)
						.font(.headline)
						.lineLimit(1)
						.truncationMode(.tail)
					Text(attribute.path)
						.font(.caption)
						.foregroundColor(.secondary)
						.lineLimit(1)
						.truncationMode(.middle)
				}
				
				Spacer()
				
				HStack(alignment: .bottom,spacing: 8) {
					toggleButton(
						icon: "photo",
						active: attribute.deleteImage
					) { attribute.deleteImage.toggle() }

					toggleButton(
						icon: "doc.text",
						active: attribute.deleteDocument
					) { attribute.deleteDocument.toggle() }

					toggleButton(
						icon: "video",
						active: attribute.deleteVideo
					) { attribute.deleteVideo.toggle() }
				}
				.padding(5)
			}
			.padding(10)
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
	
	@ViewBuilder
	private func toggleButton(icon: String, active: Bool, action: @escaping () -> Void) -> some View {
		Button(action: action) {
			Image(systemName: icon)
				.font(.system(size: 14, weight: .bold))
				.padding(10)
				.background(active ? Color.red.opacity(0.8) : Color.gray.opacity(0.2))
				.foregroundColor(active ? .white : .primary)
				.clipShape(Circle())
		}
		.buttonStyle(PlainButtonStyle())
	}
}

#Preview {
	@Previewable @StateObject var attr = FolderAttribute(name: "Desktop", path: "/tripham/Desktop")
	
	return FolderAttributeView(attribute: attr)
}

