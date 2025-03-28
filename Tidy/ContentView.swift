import SwiftUI

struct ContentView: View {
	@State private var folderName: String = ""
	@State private var searchResult: String = ""
	
	var body: some View {
		VStack(spacing: 24){
			HStack{
				TextField("Enter folder name here", text: $folderName)
					.padding(5)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(minWidth: 150)
					.onChange(of: folderName) { oldValue, newValue in
						if newValue.isEmpty {
							searchResult = ""
						}
					}
				Button("Search"){
					searchResult = "Searching for \(folderName)"
				}
				.disabled(folderName.isEmpty)
				Spacer()
			}
			Spacer()
			if folderName.isEmpty {
				Text("Results will display here")
					.foregroundColor(.gray)
			} else {
				Text(searchResult)
					.foregroundColor(.secondary)
			}
			Spacer()
		}
		.frame(minWidth: 300, minHeight: 200)
	}
}

#Preview {
	ContentView()
}
