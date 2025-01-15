//
//  Recipes.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

protocol Recipes {
    /// Returns a list of recipes for the given recipes query.
    func search(query: RecipeQuery) async -> [RecipeInfo]
}

/// Represents information about a recipe.
struct RecipeInfo: Hashable, Codable {
    var id: String
    var title: String
}

/// Represents query for searching recipes.
struct RecipeQuery: Hashable, Codable {
    var search: String = ""
    var offset: UInt32 = 0
    var limit: UInt32
}


extension RecipeInfo {
    static let sampleData: [RecipeInfo] = [
        RecipeInfo(id: "1", title: "Dish 1"),
        RecipeInfo(id: "2", title: "Dish 2")
    ]
}
