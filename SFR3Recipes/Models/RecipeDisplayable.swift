//
//  RecipeDisplayable.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

protocol RecipeDisplayable {
    var title: String { get }
    var imageURLString: String { get }
    var id: Int { get }
}

extension Recipe: RecipeDisplayable {
    var imageURLString: String {
        image
    }
}

extension SearchResult: RecipeDisplayable {}
