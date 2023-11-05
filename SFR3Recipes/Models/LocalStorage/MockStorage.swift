//
//  MockStorage.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/4/23.
//

import Foundation
import SwiftData

enum MockStorage {
    static var modelContainer = try? ModelContainer(
        for: Recipe.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
}
