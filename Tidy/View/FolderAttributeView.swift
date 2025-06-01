import SwiftUI

struct FolderAttributeView: View {
	@ObservedObject var attribute: FolderAttribute
	
	@State private var showImageExtensionPopover = false
	@State private var showDocumentExtensionPopover = false
	@State private var showVideoExtensionPopover = false
	
	var body: some View {
		VStack(alignment: .leading) {
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
				
				HStack(alignment: .bottom, spacing: 8) {
					if let imageCategory = attribute.fileCategories[.image] {
						ExtensionTogglePopoverButton(
							icon: "photo",
							fileCategory: imageCategory,
							isPopoverShown: $showImageExtensionPopover,
							popoverTitle: "Image File Types"
						)
					}
					
					if let docCategory = attribute.fileCategories[.document] {
						ExtensionTogglePopoverButton(
							icon: "doc.text",
							fileCategory: docCategory,
							isPopoverShown: $showDocumentExtensionPopover,
							popoverTitle: "Document File Types"
						)
					}
					
					if let videoCategory = attribute.fileCategories[.video] {
						ExtensionTogglePopoverButton(
							icon: "play.rectangle.fill",
							fileCategory: videoCategory,
							isPopoverShown: $showVideoExtensionPopover,
							popoverTitle: "Video File Types"
						)
					}
				}
				.padding(5)
			}
			.padding(10)
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}

#Preview {
	@Previewable @StateObject var attr = FolderAttribute(name: "Desktop", path: "/tripham/Desktop")
	FolderAttributeView(attribute: attr)
}

