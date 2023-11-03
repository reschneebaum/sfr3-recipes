//
//  SearchView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct SearchView: View {
    @Bindable var searchService: SearchService = .init()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(searchService.results) { result in
                    NavigationLink {
                        DetailView(recipe: result, networkService: searchService.networkService)
                    } label: {
                        VStack {
                            RecipeCard(recipe: result)
                            Color.gray.frame(height: 1)
                        }
                    }
                    .id(searchService.index(of: result))
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $searchService.currentIndex)
        .searchable(
            text: $searchService.searchString,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: .init("Search")
        )
        .onSubmit(of: .search) {
            guard !searchService.searchString.isEmpty else { return }
            searchService.getFirstPage()
        }
        .onChange(of: searchService.currentIndex) { oldValue, newValue in
            searchService.onIndexChanged(oldValue, newValue)
        }
        .navigationTitle("Recipe Search")
    }
}

#Preview {
    NavigationStack {
        SearchView(
            searchService: .init(
                networkService: .init(urlSession: MockNetworkSession())
            )
        )
    }
    .modelContainer(for: Recipe.self, inMemory: true)
}
