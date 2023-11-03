//
//  SearchService.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation
import Combine

@Observable
final class SearchService {
    let networkService: NetworkService
    var searchString = ""
    var currentPage = 0
    var currentIndex: Int?
    var limit: Int
    let fetchOffset: Int
    var results: [SearchResult] = []
    var error: Error?
    
    var lastIndex: Int {
        currentPage * limit
    }
    
    init(networkService: NetworkService = .init(), limit: Int = 10, fetchOffset: Int = 2) {
        self.networkService = networkService
        self.limit = limit
        self.fetchOffset = fetchOffset
    }
    
    func getFirstPage() {
        Task {
            await getFirstPage()
        }
    }
    
    func getFirstPage() async {
        await getPage(0)
    }
    
    func getNextPage() {
        Task {
            await getNextPage()
        }
    }
    
    func getNextPage() async {
        await getPage(currentPage + 1)
    }
    
    func index(of item: SearchResult) -> Int? {
        results.firstIndex { $0.id == item.id }
    }
    
    func onIndexChanged(_ oldValue: Int?, _ newValue: Int?) {
        guard let newValue,
              newValue > (oldValue ?? 0),
              newValue == lastIndex - fetchOffset else { return }
        getNextPage()
    }
    
    private func getPage(_ page: Int) async {
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
            self.error = error
        }
    }
}
