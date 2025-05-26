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
					ExtensionTogglePopoverButton(
						icon: "photo",
						isActive: attribute.shouldDeleteImage,
						toggleAction: { attribute.shouldDeleteImage.toggle() },
						isPopoverShown: $showImageExtensionPopover,
						popoverTitle: "Image File Types",
						extensions: attribute.imageFileExtensions
					)
					
					ExtensionTogglePopoverButton(
						icon: "doc.text",
						isActive: attribute.shouldDeleteDocument,
						toggleAction: { attribute.shouldDeleteDocument.toggle() },
						isPopoverShown: $showDocumentExtensionPopover,
						popoverTitle: "Document File Types",
						extensions: attribute.documentFileExtensions
					)
					
					ExtensionTogglePopoverButton(
						icon: "play.rectangle.fill",
						isActive: attribute.shouldDeleteVideo,
						toggleAction: { attribute.shouldDeleteVideo.toggle() },
						isPopoverShown: $showVideoExtensionPopover,
						popoverTitle: "Video File Types",
						extensions: attribute.videoFileExtensions
					)
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
	
	return FolderAttributeView(attribute: attr)
}

