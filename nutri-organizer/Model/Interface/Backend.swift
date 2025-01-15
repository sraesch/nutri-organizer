//
//  Backend.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

protocol Backend {
    var recipes: Recipes { get }
    var products: Products { get }
}

