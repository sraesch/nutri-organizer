//
//  NutrientsView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 16.01.25.
//

import SwiftUI

struct NutrientLineView: View {
    var name: String
    var value: String?
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            
            if let value  = value {
                Text(value)
            } else {
                Text("-")
            }
        }
    }
}

struct NutrientsView: View {
    var nutrients: Nutrients
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("nutritional_value")
                Spacer()
                Text(String(localized: "p_word") + " " + nutrients.quantity.metricString())
            }.foregroundColor(Color.accentColor)
            
            Divider()

            NutrientLineView(name: String(localized: "calories"), value: "\(nutrients.kcal) kcal")
            NutrientLineView(name: String(localized: "fat"), value: nutrients.fat?.gramString())
            NutrientLineView(name: String(localized: "carbohydrates"), value: nutrients.carbohydrates?.gramString())
            NutrientLineView(name: String(" • ") + String(localized: "sugar"), value: nutrients.sugar?.gramString())

            NutrientLineView(name: String(localized: "protein"), value: nutrients.protein?.gramString())
            NutrientLineView(name: String(localized: "salt"), value: nutrients.salt?.gramString())

            NutrientLineView(name: String(localized: "calcium"), value: nutrients.calcium?.milligramString())
            NutrientLineView(name: String(localized: "iron"), value: nutrients.iron?.milligramString())
            NutrientLineView(name: String(localized: "magnesium"), value: nutrients.magnesium?.milligramString())
            NutrientLineView(name: String(localized: "zinc"), value: nutrients.zinc?.milligramString())

            NutrientLineView(name: String(localized: "vitamin") + String(" A"), value: nutrients.vitaminA?.milligramString())
            NutrientLineView(name: String(localized: "vitamin") + String(" C"), value: nutrients.vitaminC?.milligramString())
            NutrientLineView(name: String(localized: "vitamin") + String(" D"), value: nutrients.vitaminD?.microgramString())
        }.padding()
    }
}

#Preview {
    let exampleData = InMemoryProducts().products[1].nutrients
    
    NutrientsView(nutrients: exampleData)
}
