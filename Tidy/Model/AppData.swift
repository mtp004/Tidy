//
//  AppData.swift
//  Tidy
//
//  Created by Tri Pham on 6/1/25.
//

import Foundation

class AppData: ObservableObject {
	@Published var folderData: [String: FolderAttribute] = [:]
	
	private let key = "userDataKey"
	
	init() {
		load()
	}
	
	func save() {
		do {
			let encoded = try JSONEncoder().encode(folderData)
			UserDefaults.standard.set(encoded, forKey: key)
		} catch {
			print("Failed to save: \(error)")
		}
	}
	
	func load() {
		guard let data = UserDefaults.standard.data(forKey: key) else {
			folderData = [:]
			return
		}
		do {
			folderData = try JSONDecoder().decode([String: FolderAttribute].self, from: data)
		} catch {
			print("Failed to load: \(error)")
			folderData = [:]
		}
	}
}


