//
//  Products.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

protocol Products {
    /// Searches and tries to return the product by the given ID
    func product(id: ProductID) async -> ProductInfo?
    
    /// Returns a list of products for the given products query.
    func search(query: ProductQuery) async -> [ProductInfo]
}

/// Represents query for searching products.
struct ProductQuery: Hashable, Codable {
    var search: String = ""
    var offset: UInt32 = 0
    var limit: UInt32
}

/// An ID that uniquely identifies a product
enum ProductID: Hashable, Codable {
    /// A classic bar code to identify the product
    case barcode(String)
    /// The product is being identified by a QR-code
    case qr(String)
    /// A UUID, as there is no canonic way to identify the product
    case uuid(String)
}

/// The nutrients of the product w.r.t to a certain predefined quantity
struct Nutrients: Hashable, Codable {
    var kcal: Double
    var quantity: Quantity
    var protein: Weight?
    var fat: Weight?
    var carbohydrates: Weight?
    var sugar: Weight?
    var salt: Weight?
    var vitaminA: Weight?
    var vitaminC: Weight?
    var vitaminD: Weight?
    var iron: Weight?
    var calcium: Weight?
    var magnesium: Weight?
    var sodium: Weight?
    var zinc: Weight?
}

/// High-level information about a single product
struct ProductInfo: Hashable, Codable {
    /// The id of the product. Can be EAN, GTIN, UPC,...
    /// If no id is present, e.g., bananas, a random id is used
    var id: ProductID
    
    /// The name of the product
    var name: String
    
    /// The producer of the product
    var producer: String?
    
    /// The nutrients of the product
    var nutrients: Nutrients
}

extension ProductInfo {
    static let example = ProductInfo(
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
    )
}

/// The quantity in which the product details are expressed
enum Quantity: Hashable, Codable {
    case weight(Weight)
    case volume(Volume)
    
    func metricString() -> String {
        switch self {
        case .weight(let w): return w.metricString()
        case .volume(let v): return v.metricString()
        }
    }
}
