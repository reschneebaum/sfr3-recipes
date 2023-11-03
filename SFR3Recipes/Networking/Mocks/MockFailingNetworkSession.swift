//
//  MockFailingNetworkSession.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/3/23.
//

import Foundation

final class MockFailingNetworkSession: NetworkSession {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        throw NetworkError.noResponse
    }
}
