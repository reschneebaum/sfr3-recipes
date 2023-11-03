//
//  SearchView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct SearchView: View {
    @Bindable var viewModel: SearchViewModel = .init()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.results) { result in
                    NavigationLink {
                        DetailView(recipe: result, networkService: viewModel.networkService)
                    } label: {
                        VStack {
                            RecipeCard(recipe: result)
                            Color.gray.frame(height: 1)
                        }
                    }
                    .id(viewModel.index(of: result))
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $viewModel.currentIndex)
        .searchable(
            text: $viewModel.searchString,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .onSubmit(of: .search, viewModel.search)
        .onChange(of: viewModel.currentIndex, viewModel.onIndexChanged)
        .alert(isPresented: viewModel.showAlert, error: viewModel.error) {}
        .navigationTitle("Recipe Search")
    }
}

#Preview {
    NavigationStack {
        SearchView(
            viewModel: .init(
                networkService: .init(urlSession: MockNetworkSession())
            )
        )
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
