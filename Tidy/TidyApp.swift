//
//  TidyApp.swift
//  Tidy
//
//  Created by Tri Pham on 3/27/25.
//

import SwiftUI

@main
struct TidyApp: App {
	@StateObject private var appData = AppData()
	@Environment(\.scenePhase) private var scenePhase
	
	var body: some Scene {
		Window("Tidy", id: "main") {
			ContentView(selectedEntries: $appData.folderData)
				.onAppear {
					DispatchQueue.main.async {
						if let window = NSApplication.shared.windows.first {
							window.setContentSize(NSSize(width: 600, height: 400))
						}
					}
				}
		}
		.windowResizability(.contentSize)
		.onChange(of: scenePhase) { _, newPhase in
			if newPhase == .inactive || newPhase == .background {
				appData.save()
			}
		}
	}
}
