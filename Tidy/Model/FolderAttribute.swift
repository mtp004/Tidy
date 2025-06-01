import Foundation

enum FileCategoryType: String, Codable, Hashable {
	case image
	case document
	case video
}

struct FileExtension: Identifiable, Codable {
	let id: String
	var isEnabled: Bool
	
	enum CodingKeys: String, CodingKey {
		case id, isEnabled
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
	
	init(name: String, path: String) {
		self.name = name
		self.path = path
		
		fileCategories = [
			.image: FileCategory(
				id: .image,
				shouldDelete: false,
				extensions: [
					FileExtension(id: "jpg", isEnabled: true),
					FileExtension(id: "jpeg", isEnabled: true),
					FileExtension(id: "png", isEnabled: true),
					FileExtension(id: "gif", isEnabled: true),
					FileExtension(id: "bmp", isEnabled: true),
					FileExtension(id: "tiff", isEnabled: true),
					FileExtension(id: "heic", isEnabled: true)
				]
			),
			.document: FileCategory(
				id: .document,
				shouldDelete: false,
				extensions: [
					FileExtension(id: "pdf", isEnabled: true),
					FileExtension(id: "doc", isEnabled: true),
					FileExtension(id: "docx", isEnabled: true),
					FileExtension(id: "txt", isEnabled: true),
					FileExtension(id: "rtf", isEnabled: true),
					FileExtension(id: "xls", isEnabled: true),
					FileExtension(id: "xlsx", isEnabled: true),
					FileExtension(id: "ppt", isEnabled: true),
					FileExtension(id: "pptx", isEnabled: true)
				]
			),
			.video: FileCategory(
				id: .video,
				shouldDelete: false,
				extensions: [
					FileExtension(id: "mp4", isEnabled: true),
					FileExtension(id: "mov", isEnabled: true),
					FileExtension(id: "avi", isEnabled: true),
					FileExtension(id: "mkv", isEnabled: true),
					FileExtension(id: "flv", isEnabled: true),
					FileExtension(id: "wmv", isEnabled: true),
					FileExtension(id: "webm", isEnabled: true)
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

