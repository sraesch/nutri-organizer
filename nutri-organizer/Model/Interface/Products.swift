//
//  Products.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation
import SwiftUI

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
typealias ProductID = String;

extension ProductID {
    /// Returns the id as string
    public func idString() -> String {
        return self
    }
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
    
    /// A base64 preview string
    var preview: String?
    
    /// The nutrients of the product
    var nutrients: Nutrients
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
