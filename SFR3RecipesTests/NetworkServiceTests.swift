//
//  SFR3RecipesTests.swift
//  SFR3RecipesTests
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import XCTest
@testable import SFR3Recipes

final class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!
    
    func testGetSearchResults() async throws {
        sut = .init(urlSession: MockNetworkSession())
        
        let results = try await sut.search(by: "test")
        
        XCTAssertFalse(results.results.isEmpty)
        XCTAssertEqual(results.number, 2)
        XCTAssertEqual(results.offset, 0)
    }
    
    func testGetRecipeInfo() async throws {
        sut = .init(urlSession: MockNetworkSession())
        
        let info = try await sut.getRecipeInfo(for: 0)
        
        XCTAssertEqual(info.id, 716429)
        XCTAssertEqual(info.title, "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs")
        XCTAssertEqual(info.readyInMinutes, 45)
        XCTAssertEqual(info.servings, 2)
        XCTAssertEqual(info.vegan, false)
        XCTAssertEqual(info.cuisines, [.american])
        XCTAssertTrue(info.dishTypes.contains(.main))
    }
    
    func testGetSearchResultsFails() async throws {
        sut = .init(urlSession: MockFailingNetworkSession())
        let testExpectation = expectation(description: "error caught")
        
        do {
            let results = try await sut.search(by: "test")
        } catch {
            testExpectation.fulfill()
        }
        
        await fulfillment(of: [testExpectation])
    }
    
    func testGetRecipeInfoFails() async throws {
        sut = .init(urlSession: MockFailingNetworkSession())
        let testExpectation = expectation(description: "error caught")
        
        do {
            let info = try await sut.getRecipeInfo(for: 0)
        } catch {
            testExpectation.fulfill()
        }
        
        await fulfillment(of: [testExpectation])
    }
}
