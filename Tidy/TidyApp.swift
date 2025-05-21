//
//  TidyApp.swift
//  Tidy
//
//  Created by Tri Pham on 3/27/25.
//

import SwiftUI

@main
struct TidyApp: App {
	var body: some Scene {
		Window("Tidy", id: "main") {
			ContentView()
				.onAppear {
					DispatchQueue.main.async {
						if let window = NSApplication.shared.windows.first {
							window.setContentSize(NSSize(width: 600, height: 400))
						}
					}
				}
		}
		.windowResizability(.contentSize)
	}
}
