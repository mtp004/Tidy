import SwiftUI

struct HoldButton: View {
	let title: String
	let action: () -> Void
	
	@State private var progress: Double = 0.0
	@State private var isHolding = false
	@State private var isComplete = false
	@State private var timer: Timer?
	
	private let holdDuration: Double = 2.0 // 2 seconds
	private let updateInterval: Double = 0.05 // 50ms updates
	
	var body: some View {
		ZStack {
			// Background
			RoundedRectangle(cornerRadius: 8)
				.fill(Color.blue)
				.frame(height: 44)
			
			// Progress bar background
			RoundedRectangle(cornerRadius: 8)
				.fill(Color.blue.opacity(0.3))
				.frame(height: 44)
			
			// Progress bar fill
			GeometryReader { geometry in
				HStack {
					RoundedRectangle(cornerRadius: 8)
						.fill(LinearGradient(
							gradient: Gradient(colors: [Color.green, Color.blue]),
							startPoint: .leading,
							endPoint: .trailing
						))
						.frame(width: geometry.size.width * (progress / 100))
						.animation(.linear(duration: updateInterval), value: progress)
					
					Spacer()
				}
			}
			.frame(height: 44)
			.clipped()
			
			// Button text
			Text(isComplete ? "✓ Complete!" : (isHolding ? "Hold..." : title))
				.foregroundColor(.white)
				.font(.system(size: 16, weight: .medium))
				.scaleEffect(isHolding ? 0.95 : 1.0)
				.animation(.easeInOut(duration: 0.1), value: isHolding)
		}
		.onLongPressGesture(
			minimumDuration: 0,
			maximumDistance: .infinity,
			pressing: { pressing in
				if pressing {
					startHold()
				} else {
					stopHold()
				}
			},
			perform: action
		)
		.disabled(isComplete)
		.opacity(isComplete ? 0.8 : 1.0)
	}
	
	private func startHold() {
		guard !isComplete else { return }
		
		isHolding = true
		progress = 0.0
		
		// Create timer for progress updates
		timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
			progress += (updateInterval / holdDuration) * 100
			
			if progress >= 100 {
				completeAction()
			}
		}
	}
	
	private func stopHold() {
		guard !isComplete else { return }
		
		isHolding = false
		timer?.invalidate()
		timer = nil
		
		// Reset progress with animation
		withAnimation(.easeOut(duration: 0.3)) {
			progress = 0.0
		}
	}
	
	private func completeAction() {
		timer?.invalidate()
		timer = nil
		isHolding = false
		isComplete = true
		
		// Trigger the action
		action()
		
		// Reset after 1 second
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			withAnimation(.easeInOut(duration: 0.3)) {
				isComplete = false
				progress = 0.0
			}
		}
	}
}

#Preview {
	HoldButton(title: "Hold to activate", action: {print("triggered")})
}
