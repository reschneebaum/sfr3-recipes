//
//  RecipeDisplayable.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

protocol RecipeDisplayable: Identifiable {
    var title: String { get }
    var image: String { get }
    var id: Int { get }
}

extension Recipe: RecipeDisplayable {}
extension SearchResult: RecipeDisplayable {}
