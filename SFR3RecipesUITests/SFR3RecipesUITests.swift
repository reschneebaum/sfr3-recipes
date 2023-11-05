//
//  SFR3RecipesUITests.swift
//  SFR3RecipesUITests
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import XCTest

final class SFR3RecipesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["isRunningUITests"]
        app.launch()

        continueAfterFailure = false
    }

    func testTabsAndNavigation() throws {
        let tabBar = app.tabBars["Tab Bar"]
        let searchTab = tabBar.buttons["Recipe search"]
        let favoritesTab = tabBar.buttons["My recipes"]
        
        XCTAssertTrue(searchTab.waitForExistence(timeout: 2))
        XCTAssertTrue(favoritesTab.waitForExistence(timeout: 2))
        
        XCTAssertTrue(searchTab.isSelected)
        XCTAssert(app.navigationBars["Recipe search"].exists)
        
        favoritesTab.tap()
        XCTAssertTrue(favoritesTab.isSelected)
        XCTAssert(app.navigationBars["My recipes"].exists)
    }
    
    func testSearch() throws {
        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 2))
        
        searchField.tap()
        searchField.typeText("Test")
        let searchButton = app.keyboards.buttons["Search"]
        XCTAssertTrue(searchButton.waitForExistence(timeout: 2))
        
        searchButton.tap()
        
        let firstRecipeCard = app.buttons["recipeCard-716429"]
        XCTAssertTrue(firstRecipeCard.waitForExistence(timeout: 2))
        let secondRecipeCard = app.buttons["recipeCard-715538"]
        XCTAssertTrue(secondRecipeCard.waitForExistence(timeout: 2))
        
        firstRecipeCard.tap()
        
        let backButton = app.navigationBars.buttons["Recipe search"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["Add to favorites"].exists)
    }
    
    func testAddToFavorites() throws {
        let searchField = app.searchFields["Search"]
        searchField.tap()
        searchField.typeText("Test")
        let searchButton = app.keyboards.buttons["Search"]
        searchButton.tap()
        
        // Go to detail view
        let recipeCard = app.buttons["recipeCard-716429"]
        recipeCard.tap()
        
        // Add recipe to favorites
        let favoritesButton = app.buttons["Add to favorites"]
        XCTAssertTrue(favoritesButton.exists)
        favoritesButton.tap()
        
        // Check that button text is updated
        let removeButton = app.buttons["Remove favorite"]
        XCTAssertTrue(removeButton.waitForExistence(timeout: 2))
        
        // Go to favorites view
        let tabBar = app.tabBars["Tab Bar"]
        let favoritesTab = tabBar.buttons["My recipes"]
        favoritesTab.tap()
        
        // Check that newly added recipe is visible
        let favoriteRecipeCard = app.buttons["recipeCard-716429"]
        XCTAssertTrue(favoriteRecipeCard.waitForExistence(timeout: 2))
        
        // Go back to search tab
        let searchTab = tabBar.buttons["Recipe search"]
        searchTab.tap()
        
        // Remove from favorites
        removeButton.tap()
        // Go back to favorites tab
        favoritesTab.tap()
        // Check that previously added recipe is gone
        XCTAssertFalse(favoriteRecipeCard.exists)
    }
}
