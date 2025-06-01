import SwiftUI

struct ExtensionTogglePopoverButton: View {
	let icon: String
	@ObservedObject var fileCategory: FileCategory
	@Binding var isPopoverShown: Bool
	let popoverTitle: String
	
	var body: some View {
		let extensionBinding = $fileCategory.extensions
		HStack(spacing: 1) {
			Button(action: {
				fileCategory.shouldDelete.toggle()
			}) {
				Image(systemName: icon)
					.font(.system(size: 14, weight: .bold))
					.padding(10)
					.background(fileCategory.shouldDelete ? Color.red.opacity(0.8) : Color.gray.opacity(0.2))
					.foregroundColor(fileCategory.shouldDelete ? .white : .primary)
					.clipShape(Circle())
			}
			.buttonStyle(PlainButtonStyle())
			
			Button {
				isPopoverShown.toggle()
			} label: {
				Image(systemName: "chevron.down")
					.font(.system(size: 14, weight: .semibold))
					.foregroundColor(.primary)
					.frame(width: 15, height: 25)
					.contentShape(Rectangle())
			}
			.buttonStyle(PlainButtonStyle())
			.popover(isPresented: $isPopoverShown, arrowEdge: .bottom) {
				VStack(alignment: .leading, spacing: 10) {
					Text(popoverTitle)
						.font(.headline)
					
					Divider()
					
					ForEach(extensionBinding) { $fileExtension in
						Toggle(fileExtension.id, isOn: $fileExtension.isEnabled)
					}
				}
				.padding()
				.frame(width: 220)
			}
		}
	}
}

