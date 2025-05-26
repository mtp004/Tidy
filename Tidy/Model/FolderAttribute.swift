import Foundation

class FileExtension: ObservableObject, Identifiable {
	let id = UUID()
	var name: String
	@Published var isEnabled: Bool
	
	init(name: String, isEnabled: Bool) {
		self.name = name
		self.isEnabled = isEnabled
	}
}

class FolderAttribute: ObservableObject, Identifiable {
	let id = UUID()
	var name: String
	var path: String
	
	@Published var shouldDeleteImage: Bool
	@Published var shouldDeleteDocument: Bool
	@Published var shouldDeleteVideo: Bool
	
	@Published var imageFileExtensions: [FileExtension] = [
		FileExtension(name: "jpg", isEnabled: true),
		FileExtension(name: "jpeg", isEnabled: true),
		FileExtension(name: "png", isEnabled: true),
		FileExtension(name: "gif", isEnabled: true),
		FileExtension(name: "bmp", isEnabled: true),
		FileExtension(name: "tiff", isEnabled: true),
		FileExtension(name: "heic", isEnabled: true)
	]
	
	@Published var documentFileExtensions: [FileExtension] = [
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
	
	@Published var videoFileExtensions: [FileExtension] = [
		FileExtension(name: "mp4", isEnabled: true),
		FileExtension(name: "mov", isEnabled: true),
		FileExtension(name: "avi", isEnabled: true),
		FileExtension(name: "mkv", isEnabled: true),
		FileExtension(name: "flv", isEnabled: true),
		FileExtension(name: "wmv", isEnabled: true),
		FileExtension(name: "webm", isEnabled: true)
	]
	
	init(name: String,
		 path: String,
		 deleteImage: Bool = false,
		 deleteDocument: Bool = false,
		 deleteVideo: Bool = false) {
		self.name = name
		self.path = path
		self.shouldDeleteImage = deleteImage
		self.shouldDeleteDocument = deleteDocument
		self.shouldDeleteVideo = deleteVideo
	}
}
