//
//  TidyApp.swift
//  Tidy
//
//  Created by Tri Pham on 3/27/25.
//

import SwiftUI

@main
struct TidyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SearchView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
