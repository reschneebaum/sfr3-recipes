//
//  RecipeStorageTests.swift
//  SFR3RecipesTests
//
//  Created by Rachel Schneebaum on 11/4/23.
//

import XCTest
import SwiftData
@testable import SFR3Recipes

final class RecipeStorageTests: XCTestCase {
    var context: ModelContext!
    private lazy var testIngredient = Ingredient(id: 0, amount: 2, name: "2 Tbsp", original: "2 Tbsp test ingredient", unit: "Tbsp")
    private lazy var newRecipe = Recipe(
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
            extendedIngredients: [testIngredient]
        )
    )
    
    @MainActor
    override func setUpWithError() throws {
        guard let container = MockStorage.modelContainer else {
            return XCTFail("Unable to create mock context")
        }
        context = container.mainContext
        context.delete(newRecipe)
    }
    
    override func tearDownWithError() throws {
        context.delete(newRecipe)
        try context.save()
    }
    
    @MainActor
    func testAddNewModel() async throws {
        let nilResult: Recipe? = context.registeredModel(for: newRecipe.persistentModelID)
        XCTAssertNil(nilResult)
        
        context.insert(newRecipe)
        
        let nonNilResult: Recipe? = context.registeredModel(for: newRecipe.persistentModelID)
        XCTAssertNotNil(nonNilResult)
    }
    
    @MainActor
    func testDeleteModel() async throws {
        context.insert(newRecipe)
        
        guard let savedRecipe: Recipe = context.registeredModel(for: newRecipe.persistentModelID) else {
            return XCTFail("Failed to save recipe")
        }
        
        context.delete(savedRecipe)
        try context.save()
        
        let deletedRecipe: Recipe? = context.registeredModel(for: newRecipe.persistentModelID)
        XCTAssertNil(deletedRecipe)
    }
}
