//
//  SearchViewModel.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI
import Combine

@Observable
final class SearchViewModel {
    let networkService: NetworkService
    var searchString = ""
    var currentPage = 0
    var currentIndex: Int?
    let limit: Int
    let fetchOffset: Int
    var results: [SearchResult] = []
    var error: NetworkError?
    var showAlert: Binding<Bool> {
        .init {
            self.error != nil
        } set: {
            if !$0 {
                self.error = nil
            }
        }
    }
    
    /// Index of `results.last`
    var lastIndex: Int {
        (currentPage + 1) * limit
    }
    
    /// - parameter networkService: NetworkService (defaults to newly initialized service)
    /// - parameter limit: the (max) number of search results to fetch per page (defaults to 10).
    /// - parameter fetchOffset: the index  at which to fetch a new page of results (defaults to 2) —
    /// e.g., with a `fetchOffset` of 2, a new page will be fetched when the current index is 2 from the end.
    init(networkService: NetworkService = .init(), limit: Int = 10, fetchOffset: Int = 2) {
        self.networkService = networkService
        self.limit = limit
        self.fetchOffset = fetchOffset
    }
    
    func search() {
        guard !searchString.isEmpty else { return }
        Task {
            await getFirstPage()
        }
    }
    
    func index(of item: SearchResult) -> Int? {
        results.firstIndex { $0.id == item.id }
    }
    
    func onIndexChanged(_ oldValue: Int?, _ newValue: Int?) {
        guard results.count >= limit,
              let newValue,
              newValue > (oldValue ?? 0),
              newValue == lastIndex - fetchOffset else { return }
        Task {
            await getNextPage()
        }
    }
}

private extension SearchViewModel {
    func getFirstPage() async {
        await getPage(0)
    }
    
    func getNextPage() async {
        await getPage(currentPage + 1)
    }
    
    func getPage(_ page: Int) async {
        do {
            let newResults = try await networkService.search(by: searchString, numberOfResults: limit, offset: page * limit).results
            guard !newResults.isEmpty else { return }
            
            if page == 0 {
                results = newResults
            } else {
                results.append(contentsOf: newResults)
            }
            
            currentPage = page
            error = nil
        } catch {
            results = []
            self.error = error as? NetworkError
        }
    }
}
