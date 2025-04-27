//
//  ContentView.swift
//  Tidy
//
//  Created by Tri Pham on 4/25/25.
//

import SwiftUI

enum ViewState {
	case none
	case search
}

struct ContentView: View {
	@State private var currentView: ViewState = .none
	@State private var searchURL: URL? = nil
	var body: some View {
		HStack {
			VStack(spacing: 5) {
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
				if currentView == .search {
					SearchView()
						.onAppear(){
							searchURL = BookmarkManager.loadBookmark(withKey: "home")
							if let searchURL{
								BookmarkManager.startAccessing(url: searchURL)
							}
						}
						.onDisappear(){
							if let searchURL{
								BookmarkManager.stopAccessing(url: searchURL)
							}
						}
					
				}
			}
			.frame(minWidth: 400) // Fixed width for the right side
		}
		.frame(minWidth: 300, maxHeight: .infinity)
	}
}

#Preview {
	ContentView()
}
