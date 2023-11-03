//
//  Recipe.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/1/23.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    @Attribute(.unique) var id: Int
    var title: String
    var image: String
    var summary: String
    var instructions: String
    var sourceName: String
    var sourceURL: String
    var servings: Int = 1
    var readyInMinutes: Int = 0
    var cuisines: [Cuisine]
    var dishTypes: [DishType]
    
    init(info: RecipeInfo) {
        id = info.id
        title = info.title
        image = info.image
        summary = info.summary
        instructions = info.instructions
        sourceName = info.sourceName
        sourceURL = info.sourceUrl
        servings = info.servings
        readyInMinutes = info.readyInMinutes
        cuisines = info.cuisines
        dishTypes = info.dishTypes
    }
}

extension Recipe {
    /// Saves a new recipe to the given ModelContext iff one with a matching id doesn't already exist.
    func save(in context: ModelContext) throws {
        // check if a recipe with the same id already exists
        if !exists(id, in: context) {
            context.insert(self)
            try context.save()
        } else {
            throw StorageError.nonUnique
        }
    }
    
    /// Checks if a recipe with the given id already exists.
    private func exists(_ id: Int, in context: ModelContext) -> Bool {
        let predicate = #Predicate<Recipe> { $0.id == id }
        let descriptor = FetchDescriptor(predicate: predicate)
        
        do {
            let result = try context.fetch(descriptor)
            return !result.isEmpty
        } catch {
            return false
        }
    }
}
