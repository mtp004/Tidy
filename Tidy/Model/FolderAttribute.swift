//
//  FolderAttribute.swift
//  Tidy
//
//  Created by Tri Pham on 5/25/25.
//

import Foundation

class FolderAttribute: ObservableObject, Identifiable {
	let id = UUID()
	@Published var name: String
	@Published var path: String
	@Published var deleteImage: Bool
	@Published var deleteDocument: Bool
	@Published var deleteVideo: Bool
	
	init(name: String, path: String, deleteImage: Bool = false, deleteDocument: Bool = false, deleteVideo: Bool = false) {
		self.name = name
		self.path = path
		self.deleteImage = deleteImage
		self.deleteDocument = deleteDocument
		self.deleteVideo = deleteVideo
	}
}

