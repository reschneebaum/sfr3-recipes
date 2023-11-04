//
//  SFR3RecipesApp+Config.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/4/23.
//

import Foundation

extension SFR3RecipesApp {
    static var isRunningUITests: Bool {
        ProcessInfo.processInfo.arguments.contains(LaunchArgument.isRunningUITests.rawValue)
    }
    
    enum LaunchArgument: String {
        case isRunningUITests
    }
}
