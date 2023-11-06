//
//  RecipeCard.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/2/23.
//

import SwiftUI

struct RecipeCard: View {
    let recipe: any RecipeDisplayable
    
    var body: some View {
        VStack {
            AsyncImage(url: .init(string: recipe.image)) { image in
                image
                    .interpolation(.medium)
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
                    .tint(.white)
            }
            
            HStack {
                Text(recipe.title)
                    .multilineTextAlignment(.leading)
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.accent)
        )
        .padding(.horizontal)
        .foregroundStyle(.white)
        .accessibilityElement()
        .accessibilityIdentifier("recipeCard-\(recipe.id)")
    }
}

#Preview {
    RecipeCard(recipe: MockData.previewSearchResult)
}
