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
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: Self.isRunningUITests)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    private var networkService: NetworkService = {
        Self.isRunningUITests ? .init(urlSession: MockNetworkSession()) : .init()
    }()

    var body: some Scene {
        WindowGroup {
            ContainerView(networkService: networkService)
        }
        .modelContainer(sharedModelContainer)
    }
}
