//
//  SearchView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct SearchView: View {
    @Bindable var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.results) { result in
                    NavigationLink {
                        DetailView(recipe: result, networkService: viewModel.networkService)
                    } label: {
                        RecipeCard(recipe: result)
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
        .onChange(of: viewModel.searchString, viewModel.cancelSearchIfEmpty)
        .onChange(of: viewModel.currentIndex, viewModel.onIndexChanged)
        .alert(isPresented: viewModel.showAlert, error: viewModel.error) {}
    }
}

#Preview {
    NavigationStack {
        SearchView(
            viewModel: .init(
                networkService: .init(urlSession: MockNetworkSession())
            )
        )
        .navigationTitle("Recipe search")
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
