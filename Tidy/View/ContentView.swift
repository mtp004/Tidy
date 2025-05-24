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
	@State var selectedFolderEntry: [FolderEntry] = []
	
	var body: some View {
		HStack {
			VStack(spacing: 5) {
				Button(action: {
					currentView = .home
				}) {
					Image(systemName: "house")
						.resizable()
						.scaledToFit()
						.frame(width: 24, height: 24)
						.padding(8)
						.background(Color.secondary)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
				.buttonStyle(PlainButtonStyle())
				.padding(5)
				
				Button(action: {
					currentView = .search
				}) {
					Image(systemName: "magnifyingglass")
						.resizable()
						.scaledToFit()
						.frame(width: 24, height: 24)
						.padding(8)
						.background(Color.secondary)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
				.buttonStyle(PlainButtonStyle())
				.padding(5)
				
				Spacer()
			}
			.frame(minWidth: 50, maxHeight: .infinity)
			.padding(5)
			.background(Color.black.opacity(0.1))
			
			VStack {
				PanelView()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(minWidth: 400, minHeight: 300)
	}
	
	@ViewBuilder
	func PanelView() -> some View {
		switch currentView {
		case .search:
			SearchView(
				selectedFolderEntry: $selectedFolderEntry
			)
		case .home:
			MainMenuView(
				selectedFolderEntry: $selectedFolderEntry
			)
		}
	}
}

#Preview {
	ContentView(
		selectedFolderEntry: [
			FolderEntry(name: "Desktop", path: "/Users/tripham/Desktop")
		]
	)
}
