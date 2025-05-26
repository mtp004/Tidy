import SwiftUI

struct ExtensionTogglePopoverButton: View {
	let icon: String
	let isActive: Bool
	let toggleAction: () -> Void
	@Binding var isPopoverShown: Bool
	let popoverTitle: String
	let extensions: [FileExtension]
	
	var body: some View {
		HStack(spacing: 1) {
			// Toggle button
			Button(action: toggleAction) {
				Image(systemName: icon)
					.font(.system(size: 14, weight: .bold))
					.padding(10)
					.background(isActive ? Color.red.opacity(0.8) : Color.gray.opacity(0.2))
					.foregroundColor(isActive ? .white : .primary)
					.clipShape(Circle())
			}
			.buttonStyle(PlainButtonStyle())
			
			// Arrow button with popover
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
					
					ForEach(extensions) { fileExtension in
						ExtensionToggleRow(fileExtension: fileExtension)
					}
				}
				.padding()
				.frame(width: 220)
			}
		}
	}
}

struct ExtensionToggleRow: View {
	@ObservedObject var fileExtension: FileExtension
	
	var body: some View {
		Toggle(fileExtension.name, isOn: $fileExtension.isEnabled)
	}
}

