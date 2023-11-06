//
//  SFR3RecipesApp+Config.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/4/23.
//

import Foundation

extension SFR3RecipesApp {
    static let isRunningUITests: Bool = {
        ProcessInfo.processInfo.arguments.contains(Config.isUITest.rawValue)
    }()
    
    /// Whether or not this code is running within Xcode SwiftUI Previews, which has limited functionality.
    static let isRunningInXcodePreview: Bool = {
        #if DEBUG
            ProcessInfo.processInfo.environment[Config.isPreview.rawValue] == "1"
        #else
            false
        #endif
    }()
    
    enum Config: String {
        case isUITest = "isRunningUITests"
        case isPreview = "XCODE_RUNNING_FOR_PREVIEWS"
    }
}
