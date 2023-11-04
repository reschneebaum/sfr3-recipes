//
//  Tab.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/4/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case search
    case favorites
    
    private var title: String {
        switch self {
        case .search:
            "Recipe search"
        case .favorites:
            "My recipes"
        }
    }
    
    private var icon: String {
        switch self {
        case .search:
            "magnifyingglass"
        case .favorites:
            "star"
        }
    }
}

// MARK: View Builders

extension Tab {
    var tabItem: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
        }
    }
    
    func rootView(with networkService: NetworkService) -> some View {
        Group {
            switch self {
            case .search:
                SearchView(viewModel: .init(networkService: networkService))
            case .favorites:
                FavoritesView(networkService: networkService)
            }
        }
        .navigationTitle(title)
    }
}

// MARK: Identifiable

extension Tab: Identifiable {
    var id: String {
        rawValue
    }
}
