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
    @Bindable var viewModel: DetailViewModel
    
    private var favorite: Recipe? {
        favorites.first
    }
    private var isFavorite: Bool {
        favorite != nil
    }
    
    var body: some View {
        ScrollView {
            VStack {
                RecipeCard(recipe: viewModel.recipe)
                
                Button {
                    viewModel.toggleFavorite(favorite, in: modelContext)
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                    Text(isFavorite ? "Remove favorite" : "Add to favorites")
                }
                
                if let info = viewModel.info {
                    HTMLView(html: info.summary)
                        .padding()
                }
                
                Spacer()
            }
        }
        .task {
            await viewModel.getRecipeInfo(for: favorite)
        }
        .alert(isPresented: viewModel.showAlert, error: viewModel.error) {}
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(recipe: RecipeDisplayable, networkService: NetworkService) {
        viewModel = .init(recipe: recipe, networkService: networkService)
                
        let id = recipe.id
        _favorites = Query(filter: #Predicate { $0.id == id }, sort: [SortDescriptor(\Recipe.title)])
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
