//
//  InMemoryProducts.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

struct InMemoryProducts: Products {
    private var products: [ProductInfo] = [
        ProductInfo(
            id: ProductID.barcode("5411188124689"),
            name: "Haferdrink ungesüßt, 1 Liter",
            producer: "Alpro",
            nutrients: Nutrients(
                kcal: 40.0,
                quantity: Quantity.volume(Volume(millilitre: 100)),
                protein: Weight(gram: 0.2),
                fat: Weight(gram: 1.5),
                carbohydrates: Weight(gram: 5.6),
                sugar: Weight(gram: 0.0),
                salt: Weight(gram: 0.09),
                calcium: Weight(milligram: 120)
            )
        ),
        ProductInfo(
            id: ProductID.barcode("4260026433480"),
            name: "Bio-Joghurt Griechischer Art",
            producer: "Gläserne Molkerei",
            nutrients: Nutrients(
                kcal: 100.0,
                quantity: Quantity.weight(Weight(gram: 100)),
                protein: Weight(gram: 4.5),
                fat: Weight(gram: 7.5),
                carbohydrates: Weight(gram: 3.5),
                sugar: Weight(gram: 3.5),
                salt: Weight(gram: 0.1)
            )
        )
    ]
    
    func product(id: ProductID) async -> ProductInfo? {
        for product in products {
            if product.id == id {
                return product
            }
        }
        
        return nil
    }
    
    func search(query: ProductQuery) async -> [ProductInfo] {
        // convert the given search string to lower-case in order to have a case-insensitive comparison
        let searchString = query.search.lowercased();
        
        // filter out all recipes that do not match
        let filteredProducts = self.products.filter{
            product in searchString.isEmpty || product.name.lowercased().contains(searchString)
        }.dropFirst(Int(query.offset)).prefix(Int(query.limit));
        
        return Array(filteredProducts);
    }
}
