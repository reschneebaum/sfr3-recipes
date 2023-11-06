//
//  MockNetworkSession.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import Foundation

final class MockNetworkSession: NetworkSession {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        var data: Data
        var response: HTTPURLResponse
        
        switch request.url?.lastPathComponent {
        case "complexSearch":
            let url = Bundle.main.url(forResource: "recipe-search", withExtension: "json")!
            data = try Data(contentsOf: url)
            response = .init(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            
        case "information":
            let url = Bundle.main.url(forResource: "recipe-info", withExtension: "json")!
            data = try Data(contentsOf: url)
            response = .init(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!

        default:
            data = .init()
            response = .init()
        }
        
        return (data, response)
    }
}
