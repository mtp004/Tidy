//
//  ContentView.swift
//  Tidy
//
//  Created by Tri Pham on 4/25/25.
//

import SwiftUI

enum ViewState {
	case search
	case home
}

struct ContentView: View {
	@State private var currentView: ViewState = .home
	@State var selectedFolder: Set<String> = []
	var body: some View {
		HStack {
			VStack(spacing: 5) {
				Button(action: {
					// Toggle between states
					currentView = .home
				}) {
					Image(systemName: "house")
						.resizable()
						.scaledToFit()
						.frame(width: 24, height: 24)
						.padding(8)
				}
				.buttonStyle(PlainButtonStyle())
				.background(Color.secondary)
				.foregroundColor(.white)
				.cornerRadius(10)
				.padding(5)
				
				Button(action: {
					// Toggle between states
					currentView = .search
				}) {
					Image(systemName: "magnifyingglass")
						.resizable()
						.scaledToFit()
						.frame(width: 24, height: 24)
						.padding(8)
				}
				.buttonStyle(PlainButtonStyle())
				.background(Color.secondary)
				.foregroundColor(.white)
				.cornerRadius(10)
				.padding(5)
				
				Spacer()
			}
			.frame(minWidth: 50, maxHeight: .infinity)
			.padding(5)
			.background(Color.black.opacity(0.1))
			Spacer()
			VStack {
				PanelView()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(minWidth: 700, idealWidth: 700, maxWidth: .infinity, minHeight: 400, idealHeight: 400, maxHeight: .infinity)
	}
	
	@ViewBuilder
	func PanelView() -> some View {
		switch currentView {
		case .search:
			SearchView(selectedFolder: $selectedFolder)
		case .home:
			Text("Home")
		}
	}
}

#Preview {
	ContentView(selectedFolder: ["/Users/tripham/Desktop"])
}
