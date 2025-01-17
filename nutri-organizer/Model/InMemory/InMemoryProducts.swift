//
//  InMemoryProducts.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

struct InMemoryProducts: Products {
    var products: [ProductInfo] = InMemoryProducts.load("products.json")
    
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
    
    /// Helper function to load json data from the project assets.
    private static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data


        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }


        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }


        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
