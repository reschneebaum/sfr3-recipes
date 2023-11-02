//
//  NetworkError.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

public enum NetworkError: Error {
    case badRequest
    case noResponse
    case badData
    case requestFailure(_ statusCode: Int)
}

// MARK: LocalizedError

extension NetworkError: LocalizedError {
    // TODO: Localize strings!
    public var errorDescription: String? {
        switch self {
        case .badRequest:
            "Unable to initialize and/or use the given url/urlRequest"
        case .badData:
            "Unable to parse data"
        case .noResponse:
            "No response, or no parseable response, from API"
        case let .requestFailure(statusCode):
            "Request failed with status code \(statusCode)"
        }
    }
}
