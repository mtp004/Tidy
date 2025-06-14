//
//  MainMenuView.swift
//  Tidy
//
//  Created by Tri Pham on 5/21/25.
//

import SwiftUI


struct MainMenuView: View {
	@Binding var selectedEntries: [String: FolderAttribute]
	@State private var showingSuccessAlert = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			HStack {
				Text("Selected Folders")
					.font(.title2)
				
				Spacer()
				
				HoldToConfirmButton(title: "Delete", action: {
					FileCleaner.clean(entries: selectedEntries)
					showingSuccessAlert = true
				}, buttonWidth: 120)
				.frame(alignment: .topTrailing)
				
			}
			
			if selectedEntries.isEmpty {
				Text("No folders selected.")
					.foregroundColor(.gray)
			} else {
				ScrollView {
					VStack(alignment: .leading, spacing: 5) {
						ForEach(selectedEntries.values.sorted(by: { $0.path < $1.path })) { attr in
							HStack(alignment: .top) {
								FolderAttributeView(attribute: attr)
								
								Button(action: {
									selectedEntries.removeValue(forKey: attr.path)
									
								}) {
									Image(systemName: "xmark.circle.fill")
										.foregroundColor(.red)
										.font(.title3)
								}
								.buttonStyle(PlainButtonStyle())
							}
							.background(Color.gray.opacity(0.1))
							.cornerRadius(8)
							.transition(.move(edge: .trailing).combined(with: .opacity))
						}
					}
					.animation(.easeInOut(duration: 0.5), value: selectedEntries.count)
				}
				.frame(maxHeight: 300)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
		.padding(10)
		.alert("Folder(s) successfully cleaned", isPresented: $showingSuccessAlert) {
			Button("OK", role: .cancel) { }
		}
	}
}

#Preview {
	@Previewable @State var sampleFolders: [String: FolderAttribute] = [
		"/Users/tripham/Desktop": FolderAttribute(name: "Desktop", path: "/Users/tripham/Desktop"),
		"/Users/tripham/Documents/ProjectX": FolderAttribute(name: "ProjectX", path: "/Users/tripham/Documents/ProjectX"),
		"/Users/tripham/Downloads": FolderAttribute(name: "Downloads", path: "/Users/tripham/Downloads")
	]
	return MainMenuView(selectedEntries: $sampleFolders)
}

