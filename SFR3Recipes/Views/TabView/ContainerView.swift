//
//  ContainerView.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct ContainerView: View {
    @Environment(\.modelContext) private var modelContext
    let networkService: NetworkService
    private let tabs = Tab.allCases
    
    var body: some View {
        TabView {
            ForEach(tabs) { tab in
                NavigationStack {
                    tab.rootView(with: networkService)
                }
                .tabItem { tab.tabItem }
            }
        }
    }
}

#Preview {
    ContainerView(networkService: .init(urlSession: MockNetworkSession()))
        .modelContainer(for: Recipe.self, inMemory: true)
}
