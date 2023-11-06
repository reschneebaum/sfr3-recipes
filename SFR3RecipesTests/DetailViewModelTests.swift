//
//  DetailViewModelTests.swift
//  SFR3RecipesTests
//
//  Created by Rachel Schneebaum on 11/4/23.
//

import XCTest
import SwiftData
@testable import SFR3Recipes

final class DetailViewModelTests: XCTestCase {
    var sut: DetailViewModel!
    private var context: ModelContext!
    private lazy var newRecipe = MockData.recipe
    
    @MainActor
    override func setUpWithError() throws {
        context = MockStorage.modelContainer!.mainContext
    }
    
    override func tearDownWithError() throws {
        context.delete(newRecipe)
        try context.save()
        sut = nil
    }
    
    func testToggleFavoriteWithSearchResult() throws {
        let searchResult = MockData.searchResult
        sut = .init(recipe: searchResult, networkService: .init(urlSession: MockNetworkSession()))
        sut.info = MockData.info
        
        var newRecipe: Recipe?
        let fetchDescriptor = FetchDescriptor<Recipe>(
            predicate: #Predicate { $0.id == searchResult.id },
            sortBy: []
        )
        
        // Check for a saved favorite (shouldn't exist)
        newRecipe = try context.fetch(fetchDescriptor).first
        XCTAssertNil(newRecipe)
        
        // Toggle favorite (which should save the recipe)
        sut.toggleFavorite(newRecipe, in: context)
        
        // Check for the new recipe, which should now be saved in SwiftData
        newRecipe = try context.fetch(fetchDescriptor).first
        XCTAssertNotNil(newRecipe)
    }
    
    func testToggleFavoriteWithSavedRecipe() throws {
        // Make sure new recipe is saved to SwiftData
        try newRecipe.save(in: context)
        
        sut = .init(recipe: newRecipe, networkService: .init(urlSession: MockNetworkSession()))
        let id = newRecipe.id
        
        var savedRecipe: Recipe?
        let fetchDescriptor = FetchDescriptor<Recipe>(
            predicate: #Predicate { $0.id == id },
            sortBy: []
        )
        
        // Check for the saved recipe, just to confirm it exists
        savedRecipe = try context.fetch(fetchDescriptor).first
        XCTAssertNotNil(savedRecipe)
        
        // Toggle favorite (which should delete the previously saved recipe from SwiftData)
        sut.toggleFavorite(savedRecipe, in: context)
        
        // Check that the recipe is no longer saved
        savedRecipe = try context.fetch(fetchDescriptor).first
        XCTAssertNil(savedRecipe)
    }
    
    func testGetRecipeInfoWithSearchResult() async throws {
        let searchResult = MockData.searchResult
        sut = .init(recipe: searchResult, networkService: .init(urlSession: MockNetworkSession()))
        
        XCTAssertNil(sut.info)

        await sut.getRecipeInfo(for: nil)
        
        XCTAssertNotNil(sut.info)
        XCTAssertNil(sut.error)
    }
    
    func testGetRecipeInfoWithSavedRecipe() async throws {
        let savedRecipe = MockData.recipe
        sut = .init(recipe: savedRecipe, networkService: .init(urlSession: MockNetworkSession()))
        
        XCTAssertNil(sut.info)
        
        await sut.getRecipeInfo(for: savedRecipe)
        
        XCTAssertNotNil(sut.info)
        XCTAssertEqual(sut.info?.id, savedRecipe.id)
        XCTAssertEqual(sut.info?.title, savedRecipe.title)
        XCTAssertEqual(sut.info?.image, savedRecipe.image)
    }
    
    func testGetRecipeInfoFails() async throws {
        let searchResult = MockData.searchResult
        sut = .init(recipe: searchResult, networkService: .init(urlSession: MockFailingNetworkSession()))
        
        XCTAssertNil(sut.info)

        await sut.getRecipeInfo(for: nil)
        
        XCTAssertNil(sut.info)
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(sut.showAlert.wrappedValue)
    }
}
