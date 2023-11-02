//
//  SpoonacularEndpoint.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

enum SpoonacularEndpoint: Endpoint {
    case search(String)
    case getInfo(Int)
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.spoonacular.com"
    }
    
    var path: String {
        switch self {
        case .search:
            "/recipes/complexSearch"
        case .getInfo(let id):
            "/recipes/\(id)/information"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .search, .getInfo:
                .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let searchString):
            [.init(name: "query", value: searchString)]
        case .getInfo:
            nil
        }
    }
    
    var httpHeaders: [String: String]? {
        ["x-api-key": Self.apiKey]
    }
    
    private static let apiKey = "983d418311a446b5be1385ed4a1b3612"
}
