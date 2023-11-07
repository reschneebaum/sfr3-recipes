//
//  HTTPClient.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

public protocol HTTPClient {
    associatedtype EndpointType: Endpoint
    var urlSession: NetworkSession { get }
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T
}

public extension HTTPClient {
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> T {
        guard let urlRequest = endpoint.urlRequest else {
            throw NetworkError.badRequest
        }

        let (data, response) = try await urlSession.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailure(httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
