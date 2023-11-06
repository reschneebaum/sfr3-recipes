//
//  MockData.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/6/23.
//

import Foundation

enum MockData {
    static var ingredient = Ingredient(
        id: 0,
        amount: 2,
        name: "2 Tbsp",
        original: "2 Tbsp test ingredient",
        unit: "Tbsp"
    )
    
    static var recipe = Recipe(
        info: .init(
            id: 1,
            title: "Test Recipe",
            image: "https://foo.bar",
            servings: 2,
            readyInMinutes: 30,
            sourceName: "Test Source",
            sourceUrl: "https://foo.bar",
            spoonacularSourceUrl: "https://foo.bar",
            cuisines: [.american, .asian, .chinese],
            instructions: "Test instructions",
            dishTypes: [.main],
            summary: "Test summary",
            extendedIngredients: [ingredient]
        )
    )
    
    static var searchResult = SearchResult(
        id: 2,
        title: "Test Recipe 2",
        image: "https://foo.bar"
    )
    
    static var info = RecipeInfo(
        id: searchResult.id,
        title: searchResult.title,
        image: searchResult.image,
        servings: 1,
        readyInMinutes: 0,
        sourceName: "",
        sourceUrl: "",
        spoonacularSourceUrl: "",
        cuisines: [],
        instructions: "",
        dishTypes: [],
        summary: "",
        extendedIngredients: []
    )
}
