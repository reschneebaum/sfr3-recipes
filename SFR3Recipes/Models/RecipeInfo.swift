//
//  RecipeInfo.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import Foundation

struct RecipeInfo: Codable {
    let id: Int
    let title: String
    let image: String
    var servings: Int
    var readyInMinutes: Int
    var license: String?
    var sourceName: String
    var sourceUrl: String
    var spoonacularSourceUrl: String
    var healthScore: Double?
    var spoonacularScore: Double?
    var pricePerServing: Double?
    var cheap: Bool?
    var creditsText: String?
    var cuisines: [Cuisine]
    var dairyFree: Bool?
    var glutenFree: Bool?
    var instructions: String
    var ketogenic: Bool?
    var lowFodmap: Bool?
    var sustainable: Bool?
    var vegan: Bool?
    var vegetarian: Bool?
    var veryHealthy: Bool?
    var veryPopular: Bool?
    var whole30: Bool?
    var weightWatcherSmartPoints: Int?
    var dishTypes: [DishType]
    var summary: String
    var extendedIngredients: [Ingredient]
}

extension RecipeInfo {
    var displayableIngredients: String {
        extendedIngredients.map { "• \($0.original)" }.joined(separator: "\n")
    }
    
    init(_ recipe: Recipe) {
        id = recipe.id
        title = recipe.title
        image = recipe.image
        servings = recipe.servings
        readyInMinutes = recipe.readyInMinutes
        sourceName = recipe.sourceName
        sourceUrl = recipe.sourceURL
        spoonacularSourceUrl = ""
        cuisines = recipe.cuisines
        instructions = recipe.instructions
        dishTypes = recipe.dishTypes
        summary = recipe.summary
        extendedIngredients = recipe.ingredients
    }
}
