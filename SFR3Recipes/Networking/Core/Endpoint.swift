//
//  Endpoint.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

/// Specifies the properties required to create a `URLRequest` for a particular API endpoint.
public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var httpHeaders: [String: String]? { get }
}

public extension Endpoint {
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return nil
        }
        
        var request: URLRequest = .init(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = httpHeaders
        
        return request
    }
}
