//
//  Recipe.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var id: Int
    var title: String
    var isFavorite: Bool
    var info: RecipeInfo
    
    init(info: RecipeInfo) {
        self.id = info.id
        self.title = info.title
        self.isFavorite = true
        self.info = info
    }
}
