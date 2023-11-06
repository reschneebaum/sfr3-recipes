//
//  MockData.swift
//  SFR3Recipes
//
//  Created by Rachel Schneebaum on 11/6/23.
//

import Foundation

enum MockData {
    static var ingredient = Ingredient(
        id: 0,
        amount: 2,
        name: "2 Tbsp",
        original: "2 Tbsp test ingredient",
        unit: "Tbsp"
    )
    
    static var recipe = Recipe(
        info: .init(
            id: 1,
            title: "Test Recipe",
            image: "https://foo.bar",
            servings: 2,
            readyInMinutes: 30,
            sourceName: "Test Source",
            sourceUrl: "https://foo.bar",
            spoonacularSourceUrl: "https://foo.bar",
            cuisines: [.american, .asian, .chinese],
            instructions: "Test instructions",
            dishTypes: [.main],
            summary: "Test summary",
            extendedIngredients: [ingredient]
        )
    )
    
    static var searchResult = SearchResult(
        id: 2,
        title: "Test Recipe 2",
        image: "https://foo.bar"
    )
    
    static var previewSearchResult = SearchResult(
        id: 0,
        title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
        image: "https://spoonacular.com/recipeImages/716429-312x231.jpg"
    )
    
    static var info = RecipeInfo(
        id: searchResult.id,
        title: searchResult.title,
        image: searchResult.image,
        servings: 1,
        readyInMinutes: 0,
        sourceName: "",
        sourceUrl: "",
        spoonacularSourceUrl: "",
        cuisines: [],
        instructions: "",
        dishTypes: [],
        summary: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs might be a good recipe to expand your main course repertoire. One portion of this dish contains approximately <b>19g of protein </b>,  <b>20g of fat </b>, and a total of  <b>584 calories </b>. For  <b>$1.63 per serving </b>, this recipe  <b>covers 23% </b> of your daily requirements of vitamins and minerals. This recipe serves 2. It is brought to you by fullbellysisters.blogspot.com. 209 people were glad they tried this recipe. A mixture of scallions, salt and pepper, white wine, and a handful of other ingredients are all it takes to make this recipe so scrumptious. From preparation to the plate, this recipe takes approximately  <b>45 minutes </b>. All things considered, we decided this recipe  <b>deserves a spoonacular score of 83% </b>. This score is awesome. If you like this recipe, take a look at these similar recipes: <a href=\"https://spoonacular.com/recipes/cauliflower-gratin-with-garlic-breadcrumbs-318375\">Cauliflower Gratin with Garlic Breadcrumbs</a>, <a href=\"https://spoonacular.com/recipes/pasta-with-cauliflower-sausage-breadcrumbs-30437\">Pasta With Cauliflower, Sausage, & Breadcrumbs</a>, and <a href=\"https://spoonacular.com/recipes/pasta-with-roasted-cauliflower-parsley-and-breadcrumbs-30738\">Pasta With Roasted Cauliflower, Parsley, And Breadcrumbs</a>.",
        extendedIngredients: []
    )
}
