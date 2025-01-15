//
//  Recipes.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

struct InMemoryRecipes: Recipes {
    /// List of predefined recipes
    private var recipes: [Recipe] = [
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 20), id: "1", title: "Spaghetti Carbonari"),
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 21), id: "2", title: "Spaghetti Bolognese"),
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 22), id: "3", title: "Spaghetti Napoli"),
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 23), id: "4", title: "Spaghetti Aglio e Olio"),
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 24), id: "5", title: "Beef Wellington"),
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 25), id: "6", title: "Wiener Schnitzel"),
        Recipe(date: InMemoryRecipes.createDate(year: 2024, month: 10, day: 26), id: "7", title: "Wiener Würstchen")
    ]
    
    /// Internal helper function to create a a single date for the given year, month and day value.
    static func createDate(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        
        var dateComponents: DateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        if let date = calendar.date(from: dateComponents) {
            return date;
        } else {
            fatalError("Could not create date!!!")
        }
    }
    
    func search(query: RecipeQuery) async -> [RecipeInfo] {
        // convert the given search string to lower-case in order to have a case-insensitive comparison
        let searchString = query.search.lowercased();
        
        // filter out all recipes that do not match
        let filteredRecipes = self.recipes.filter{
            recipe in searchString.isEmpty || recipe.title.lowercased().contains(searchString)
        }.dropFirst(Int(query.offset)).prefix(Int(query.limit));
        
        // map recipes to recipe info
        let recipeInfos: [RecipeInfo] = filteredRecipes.map{recipe in recipe.info()};
        
        return recipeInfos;
    }
}

struct Recipe {
    var date: Date
    var id: String
    var title: String
    
    public func info() -> RecipeInfo {
        return RecipeInfo(id: self.id, title: self.title);
    }
}
