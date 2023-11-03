//
//  ContainerView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

enum Tab {
    case search
    case favorites
    
    var title: String {
        switch self {
        case .search:
            "Search"
        case .favorites:
            "My recipes"
        }
    }
    
    var icon: String {
        switch self {
        case .search:
            "magnifyingglass"
        case .favorites:
            "star"
        }
    }
    
    var tabItem: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
        }
    }
}

struct ContainerView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var searchService: SearchService = .init()
    
    var body: some View {
        TabView {
            NavigationStack {
                SearchView(searchService: searchService)
            }
            .tabItem {
                Tab.search.tabItem
            }
            
            NavigationStack {
                FavoritesView(networkService: searchService.networkService)
            }
            .tabItem {
                Tab.favorites.tabItem
            }
        }
    }
}

#Preview {
    ContainerView(searchService: .init(networkService: .init(urlSession: MockNetworkSession())))
        .modelContainer(for: Recipe.self, inMemory: true)
}
