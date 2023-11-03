//
//  DetailView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [Recipe]
    
    @State private var info: RecipeInfo?
    private let recipe: RecipeDisplayable
    private let networkService: NetworkService
    
    private var favorite: Recipe? {
        favorites.first
    }
    private var isFavorite: Bool {
        favorite != nil
    }
    
    var body: some View {
        ScrollView {
            VStack {
                RecipeCard(recipe: recipe)
                
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                    Text(isFavorite ? "Remove favorite" : "Add to favorites")
                }
                
                if let summary = info?.summary, !summary.isEmpty {
                    HTMLView(html: summary)
                        .padding()
                }
                
                Spacer()
            }
        }
        .task {
            guard info == nil else { return }
            if let favorite {
                info = .init(favorite)
            } else {
                info = try? await networkService.getRecipeInfo(for: recipe.id)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(recipe: RecipeDisplayable, networkService: NetworkService) {
        self.recipe = recipe
        self.networkService = networkService
                
        let id = recipe.id
        _favorites = Query(filter: #Predicate { $0.id == id }, sort: [SortDescriptor(\Recipe.title)])
    }
    
    func toggleFavorite() {
        if let favorite {
            modelContext.delete(favorite)
        } else if let info {
            let newFavorite = Recipe(info: info)
            try? newFavorite.save(in: modelContext)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(
            recipe: SearchResult(
                id: 0,
                title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
                imageURLString: "https://spoonacular.com/recipeImages/716429-312x231.jpg"
            ),
            networkService: .init(urlSession: MockNetworkSession())
        )
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
