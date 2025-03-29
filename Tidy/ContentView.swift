import SwiftUI

struct ContentView: View {
	@State private var folderName: String = ""
	@State private var searchResults: [String] = []  // ✅ Store multiple results as an array
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
					searchResults = ["Searching for \(folderName)..."]
					performSearch()
				}
				.disabled(folderName.isEmpty)
				
				Spacer()
			}
			
			Spacer()
			
			if searchResults.isEmpty {
				Text("Results will display here")
					.foregroundColor(.gray)
			} else {
				ScrollView {
					VStack(alignment: .leading, spacing: 8) {
						// ✅ FIX: Use `.self` as an identifier
						ForEach(searchResults, id: \.self) { result in
							Text(result)
								.frame(maxWidth: .infinity, alignment: .leading)
								.padding(.horizontal)
						}
					}
					.padding(.vertical)
				}
				.frame(maxHeight: 150)  // Limit scrollable height
				.border(Color.gray, width: 1) // Add border for visibility
			}
			
			Spacer()
		}
		.frame(minWidth: 300, minHeight: 200)
		.padding()
	}
	
	private func performSearch() {
		// Get the user's home directory
		let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
		print(homeDirectory)
		
		// Get the Desktop directory
		
		// Perform the search in the Desktop directory
		searchManager.searchForFolders(inDirectory: homeDirectory, matching: folderName) { results in
			DispatchQueue.main.async {
				if results.isEmpty {
					searchResults = ["No matching folders found."]
				} else {
					searchResults = results
				}
			}
		}
	}
}

#Preview {
	ContentView()
}

