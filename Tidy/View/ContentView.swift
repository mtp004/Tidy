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
	case setting
}

struct ContentView: View {
	@State private var currentView: ViewState = .home
	@Binding var selectedEntries: [String: FolderAttribute]
	
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
						.background(currentView == .home
									? Color.secondary
									: Color.clear)
						.foregroundColor(.white)
						.cornerRadius(10)
						.contentShape(Rectangle())
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
						.background(currentView == .search
									? Color.secondary
									: Color.clear)
						.foregroundColor(.white)
						.cornerRadius(10)
						.contentShape(Rectangle())
				}
				.buttonStyle(PlainButtonStyle())
				.padding(5)
				
				Button(action: {
					currentView = .setting
				}) {
					Image(systemName: "gearshape.fill")
						.resizable()
						.scaledToFit()
						.frame(width: 24, height: 24)
						.padding(8)
						.background(currentView == .setting
									? Color.secondary
									: Color.clear)
						.foregroundColor(.white)
						.cornerRadius(10)
						.contentShape(Rectangle())
				}
				.buttonStyle(PlainButtonStyle())
				.padding(5)
				
				Spacer()
			}
			.frame(minWidth: 50, maxHeight: .infinity)
			.padding(4)
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
				selectedEntry: $selectedEntries
			)
		case .home:
			MainMenuView(selectedEntries: $selectedEntries)
		case .setting:
			SettingsView(selectedEntries: $selectedEntries)
		}
	}
}


#Preview {
	ContentView(
		selectedEntries: .constant([
			"/Users/tripham/Desktop": FolderAttribute(name: "Desktop", path: "/Users/tripham/Desktop"),
			"/Users/tripham/Downloads": FolderAttribute(name: "Downloads", path: "/Users/tripham/Downloads")
		])
	)
}


