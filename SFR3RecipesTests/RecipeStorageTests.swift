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
    private lazy var newRecipe = MockData.recipe
    
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
