//
//  DetailViewModel.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/3/23.
//

import SwiftUI
import SwiftData

@Observable
final class DetailViewModel {
    let recipe: RecipeDisplayable
    let networkService: NetworkService
    var info: RecipeInfo?
    var error: NetworkError?
    var showAlert: Binding<Bool> {
        .init {
            self.error != nil
        } set: {
            if !$0 {
                self.error = nil
            }
        }
    }
    
    init(recipe: RecipeDisplayable, networkService: NetworkService) {
        self.recipe = recipe
        self.networkService = networkService
    }
    
    func toggleFavorite(_ favorite: Recipe?, in modelContext: ModelContext) {
        if let favorite {
            modelContext.delete(favorite)
        } else if let info {
            let newFavorite = Recipe(info: info)
            try? newFavorite.save(in: modelContext)
        }
    }
    
    func getRecipeInfo(for favorite: Recipe?) async {
        guard info == nil else { return }
        
        if let favorite {
            info = .init(favorite)
        } else {
            do {
                info = try await networkService.getRecipeInfo(for: recipe.id)
            } catch {
                self.error = error as? NetworkError
            }
        }
    }
}
