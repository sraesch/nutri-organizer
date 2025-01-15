//
//  RecipesView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 14.01.25.
//

import SwiftUI

struct RecipesView: View {
    @State private var searchString: String = ""
    @State private var recipeInfos: [RecipeInfo] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipeInfos, id: \.id) { recipeInfo in
                    NavigationLink {
                        Text(recipeInfo.title)
                    } label: {
                        Text(recipeInfo.title)
                    }
                }
            }
            .navigationTitle(String(localized: "recipes"))
            .animation(.default, value: recipeInfos)
        }
        .searchable(text: $searchString)
        .task(id: searchString) {
            await updateRecipeInfos()
        }
    }
    
    private func updateRecipeInfos() async {
        recipeInfos = await backend().recipes.search(query: RecipeQuery(search: searchString, limit: 40))
    }
}

#Preview {
    RecipesView()
}
