//
//  Ingredient.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/3/23.
//

import Foundation

struct Ingredient: Codable {
    let id: Int
    let amount: Double
    let name: String
    let original: String
    let unit: String
}
