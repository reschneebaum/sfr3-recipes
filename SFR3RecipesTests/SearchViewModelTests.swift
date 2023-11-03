//
//  SearchViewModelTests.swift
//  SFR3RecipesTests
//
//  Created by Rachel Schneebaum on 11/3/23.
//

import XCTest
@testable import SFR3Recipes

final class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!

    func testGetFirstPage() async throws {
        sut = .init(networkService: .init(urlSession: MockNetworkSession()), limit: 2, fetchOffset: 1)
        
        await sut.getFirstPage()
        
        XCTAssertEqual(sut.results.count, 2)
        XCTAssertNil(sut.error)
    }
    
    func testGetNextPage() async throws {
        sut = .init(networkService: .init(urlSession: MockNetworkSession()), limit: 2, fetchOffset: 1)
        
        await sut.getFirstPage()
        await sut.getNextPage()
        
        XCTAssertEqual(sut.results.count, 4)
        XCTAssertNil(sut.error)
    }
    
    func testGetFirstPageFails() async throws {
        sut = .init(networkService: .init(urlSession: MockFailingNetworkSession()), limit: 2, fetchOffset: 1)
        
        await sut.getFirstPage()
        
        XCTAssertEqual(sut.results.count, 0)
        XCTAssertNotNil(sut.error)
    }
    
    func testGetNextPageFails() async throws {
        sut = .init(networkService: .init(urlSession: MockFailingNetworkSession()), limit: 2, fetchOffset: 1)
        
        await sut.getFirstPage()
        await sut.getNextPage()
        
        XCTAssertEqual(sut.results.count, 0)
        XCTAssertNotNil(sut.error)
    }
}
