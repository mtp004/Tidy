import SwiftUI

struct ContentView: View {
	@State private var folderName: String = ""
	@State private var searchResults: [FolderEntry] = []  // ✅ Store multiple results as an array
	private let searchManager = MetadataSearchManager()  // Instance of search manager
	
	var body: some View {
		VStack(spacing: 16) {
			HStack {
				TextField("Enter folder name here", text: $folderName)
					.padding(5)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(minWidth: 150)
					.onChange(of: folderName) { oldValue, newValue in
						if newValue.isEmpty {
							searchResults = []
						}
					}
				
				Button("Search") {
					performSearch()
				}
				.disabled(folderName.isEmpty)
				
				Spacer()
			}
			
			if searchResults.isEmpty {
				Text("Results will display here")
					.foregroundColor(.gray)
			} else {
				ScrollView {
					VStack(alignment: .leading, spacing: 8) {
						// ✅ FIX: Use `.self` as an identifier
						ForEach(searchResults, id: \.path) { entry in
							FolderEntryView(entry: entry)
						}
					}
					.padding(.vertical)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)  // Limit scrollable height
				.background(Color(NSColor.controlBackgroundColor))
				.clipShape(RoundedRectangle(cornerRadius: 8))
				.padding(5)
			}
			
			Spacer()
		}
		.frame(minWidth: 300, minHeight: 200)
		.padding(5)
	}
	
	private func performSearch() {
		// Get the user's home directory
		let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
		print(homeDirectory)
		
		// Perform the search in the Desktop directory
		searchManager.searchForFolders(inDirectory: homeDirectory, matching: folderName) { results in
			DispatchQueue.main.async {
				if !results.isEmpty {

					searchResults = results
				}
			}
		}
	}
}

#Preview {
	ContentView()
}

