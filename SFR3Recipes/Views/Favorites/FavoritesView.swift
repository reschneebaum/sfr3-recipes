//
//  MyRecipesView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recipes: [Recipe]
    let networkService: NetworkService
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(recipes) { recipe in
                    NavigationLink {
                        DetailView(recipe: recipe, networkService: networkService)
                    } label: {
                        VStack {
                            RecipeCard(recipe: recipe)
                            Color.gray.frame(height: 1)
                        }
                    }
                }
            }
        }
        .navigationTitle("My recipes")
    }
}

#Preview {
    NavigationStack {
        FavoritesView(networkService: .init(urlSession: MockNetworkSession()))
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
