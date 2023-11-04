//
//  SearchResult.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import Foundation

struct SearchResults: Codable {
    let offset: Int
    let number: Int
    let results: [SearchResult]
    let totalResults: Int
}

struct SearchResult: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
}
