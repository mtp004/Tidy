import SwiftUI

struct HoldToConfirmButton: View {
	let title: String
	let action: () -> Void
	
	let buttonWidth: CGFloat
	let buttonHeight: CGFloat = 30
	
	@State private var progress: CGFloat = 0.0
	@State private var isHolding = false
	@State private var timer: Timer?
	
	let holdDuration: TimeInterval = 1.5
	let updateInterval: TimeInterval = 0.02
	
	var body: some View {
		ZStack(alignment: .leading) {
			RoundedRectangle(cornerRadius: 8)
				.fill(Color.red.opacity(0.4))
				.frame(width: buttonWidth, height: buttonHeight)
			
			RoundedRectangle(cornerRadius: 8)
				.fill(Color(NSColor.red))
				.frame(width: progress * buttonWidth, height: buttonHeight)
			
			Text(isHolding ? "Confirming..." : title)
				.foregroundColor(.primary)
				.bold()
				.frame(width: buttonWidth, height: buttonHeight)
		}
		.contentShape(Rectangle())
		.gesture(
			DragGesture(minimumDistance: 0)
				.onChanged { _ in
					if !isHolding {
						startHold()
					}
				}
				.onEnded { _ in
					cancelHold()
				}
		)
	}
	
	private func startHold() {
		isHolding = true
		progress = 0.0
		
		timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
			progress += CGFloat(updateInterval / holdDuration)
			if progress >= 1.0 {
				timer?.invalidate()
				timer = nil
				isHolding = false
				progress = 0.0
				action()
			}
		}
	}
	
	private func cancelHold() {
		timer?.invalidate()
		timer = nil
		isHolding = false
		progress = 0.0
	}
}

#Preview {
	HoldToConfirmButton(title: "Delete", action: {
		print("Confirmed!")
	}, buttonWidth: 120)
}

