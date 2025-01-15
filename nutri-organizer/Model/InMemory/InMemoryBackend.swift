//
//  Backend.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

struct InMemoryBackend: Backend {
    static var backend: Backend = InMemoryBackend()
    
    var recipes: Recipes = InMemoryRecipes()
}

func backend() -> Backend {
    return InMemoryBackend.backend
}

