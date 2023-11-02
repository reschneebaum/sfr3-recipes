//
//  NetworkService.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

final class NetworkService: HTTPClient {
    typealias EndpointType = SpoonacularEndpoint
    
    var urlSession: NetworkSession
    
    init(urlSession: NetworkSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func search(by searchString: String) async throws -> SearchResults {
        try await request(.search(searchString))
    }
    
    func getRecipeInfo(for id: Int) async throws -> RecipeInfo {
        try await request(.getInfo(id))
    }
}
