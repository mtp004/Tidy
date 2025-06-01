import Foundation

enum FileCategoryType: String, Codable, Hashable {
	case image
	case document
	case video
}

struct FileExtension: Identifiable, Codable {
	let id = UUID()
	let name: String
	var isEnabled: Bool
	
	enum CodingKeys: String, CodingKey {
		case name, isEnabled
	}
}

class FileCategory: ObservableObject, Identifiable, Codable {
	let id: FileCategoryType
	@Published var shouldDelete: Bool
	@Published var extensions: [FileExtension]
	
	init(id: FileCategoryType, shouldDelete: Bool, extensions: [FileExtension]) {
		self.id = id
		self.shouldDelete = shouldDelete
		self.extensions = extensions
	}
	
	enum CodingKeys: String, CodingKey {
		case id, shouldDelete, extensions
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(FileCategoryType.self, forKey: .id)
		shouldDelete = try container.decode(Bool.self, forKey: .shouldDelete)
		extensions = try container.decode([FileExtension].self, forKey: .extensions)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(shouldDelete, forKey: .shouldDelete)
		try container.encode(extensions, forKey: .extensions)
	}
}

class FolderAttribute: ObservableObject, Identifiable, Codable {
	let id = UUID()
	var name: String
	var path: String
	@Published var fileCategories: [FileCategoryType: FileCategory] = [:]
	
	// Your existing init stays the same
	init(name: String, path: String) {
		self.name = name
		self.path = path
		
		fileCategories = [
			.image: FileCategory(
				id: .image,
				shouldDelete: false,
				extensions: [
					FileExtension(name: "jpg", isEnabled: true),
					FileExtension(name: "jpeg", isEnabled: true),
					FileExtension(name: "png", isEnabled: true),
					FileExtension(name: "gif", isEnabled: true),
					FileExtension(name: "bmp", isEnabled: true),
					FileExtension(name: "tiff", isEnabled: true),
					FileExtension(name: "heic", isEnabled: true)
				]
			),
			.document: FileCategory(
				id: .document,
				shouldDelete: false,
				extensions: [
					FileExtension(name: "pdf", isEnabled: true),
					FileExtension(name: "doc", isEnabled: true),
					FileExtension(name: "docx", isEnabled: true),
					FileExtension(name: "txt", isEnabled: true),
					FileExtension(name: "rtf", isEnabled: true),
					FileExtension(name: "xls", isEnabled: true),
					FileExtension(name: "xlsx", isEnabled: true),
					FileExtension(name: "ppt", isEnabled: true),
					FileExtension(name: "pptx", isEnabled: true)
				]
			),
			.video: FileCategory(
				id: .video,
				shouldDelete: false,
				extensions: [
					FileExtension(name: "mp4", isEnabled: true),
					FileExtension(name: "mov", isEnabled: true),
					FileExtension(name: "avi", isEnabled: true),
					FileExtension(name: "mkv", isEnabled: true),
					FileExtension(name: "flv", isEnabled: true),
					FileExtension(name: "wmv", isEnabled: true),
					FileExtension(name: "webm", isEnabled: true)
				]
			)
		]
	}
	
	enum CodingKeys: String, CodingKey {
		case name, path, fileCategories
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		path = try container.decode(String.self, forKey: .path)
		fileCategories = try container.decode([FileCategoryType: FileCategory].self, forKey: .fileCategories)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(path, forKey: .path)
		try container.encode(fileCategories, forKey: .fileCategories)
	}
}
