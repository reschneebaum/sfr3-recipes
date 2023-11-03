//
//  SFR3RecipesApp.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import SwiftUI
import SwiftData

@main
struct SFR3RecipesApp: App {
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([Recipe.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContainerView(networkService: .init())
        }
        .modelContainer(sharedModelContainer)
    }
}
