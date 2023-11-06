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
            VStack(alignment: .leading, spacing: 12) {
                RecipeCard(recipe: viewModel.recipe)
                    .font(.title)
                
                Button {
                    viewModel.toggleFavorite(favorite, in: modelContext)
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                    Text(isFavorite ? "Remove favorite" : "Add to favorites")
                }
                .font(.system(.headline, design: .rounded, weight: .bold))
                .padding(.horizontal, 24)
                
                if let info = viewModel.info {
                    additionalInfoView(info)
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
    
    // MARK: Init
    
    init(recipe: any RecipeDisplayable, networkService: NetworkService) {
        viewModel = .init(recipe: recipe, networkService: networkService)
                
        let id = recipe.id
        _favorites = Query(filter: #Predicate { $0.id == id }, sort: [SortDescriptor(\Recipe.title)])
    }
}

// MARK: Subviews

private extension DetailView {
    func additionalInfoView(_ info: RecipeInfo) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HTMLView(html: info.summary)
            
            Rectangle()
                .fill(.accent)
                .frame(height: 0.6)
            
            if info.readyInMinutes > 0 {
                HStack(spacing: 4) {
                    Text("Ready in:")
                        .font(.system(.headline, weight: .bold))
                    Text("\(info.readyInMinutes) minutes")
                    Spacer()
                }
            }
            
            if !info.displayableIngredients.isEmpty {
                VStack(alignment: .leading) {
                    Text("Ingredients:")
                        .font(.system(.headline, weight: .bold))
                    Text(info.displayableIngredients)
                }
            }
            
            if !info.instructions.isEmpty {
                VStack(alignment: .leading) {
                    Text("Instructions:")
                        .font(.system(.headline, weight: .bold))
                    HTMLView(html: info.instructions)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        DetailView(
            recipe: MockData.previewSearchResult,
            networkService: .init(urlSession: MockNetworkSession())
        )
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
