//
//  RecipePreview.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import SwiftUI

struct RecipePreview: View {
    let recipeInfo: RecipeInfo
    
    var body: some View {
        HStack {
            Text(recipeInfo.title)
            Spacer()
        }.padding()
    }
}

struct RecipePreview_Previews: PreviewProvider {
    static var recipeInfo = RecipeInfo(id: "42", title: "Beef Wellington")

    static var previews: some View {
        RecipePreview(recipeInfo: recipeInfo)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
