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
        if Self.shouldUseMocks {
            guard let mockContainer = MockStorage.modelContainer else {
                fatalError("Cound not create mock ModelContainer")
            }
            return mockContainer
        } else {
            let schema = Schema([Recipe.self])
            let modelConfiguration = ModelConfiguration(schema: schema)
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
    }()
    
    private var networkService: NetworkService = {
        Self.shouldUseMocks ? .init(urlSession: MockNetworkSession()) : .init()
    }()

    var body: some Scene {
        WindowGroup {
            ContainerView(networkService: networkService)
        }
        .modelContainer(sharedModelContainer)
    }
}
