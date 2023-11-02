//
//  SearchResult.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import Foundation

struct SearchResults: Codable {
    var offset: Int
    var number: Int
    var results: [SearchResult]
    var totalResults: Int
}

struct SearchResult {
    var id: Int
    var title: String
    var imageURLString: String
}

extension SearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURLString = "image"
    }
}
