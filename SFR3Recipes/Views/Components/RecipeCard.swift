//
//  RecipeCard.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: RecipeDisplayable
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.title)
            AsyncImage(url: .init(string: recipe.imageURLString)) { image in
                image
                    .interpolation(.medium)
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecipeCard(
        recipe: SearchResult(
            id: 0,
            title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
            imageURLString: "https://spoonacular.com/recipeImages/716429-312x231.jpg"
        )
    )
}
