//
//  Units.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import Foundation

/// Weight unit
struct Weight: Hashable, Codable {
    /// The weight value expressed in gram
    var value: Double
    
    public init(gram: Double) {
        value = gram
    }
    
    public init(milligram: Double) {
        value = milligram * 1e-3
    }
    
    /// Returns the weight as gram
    func gram() -> Double {
        return value
    }
    
    /// Returns the weight as milligram
    func milligram() -> Double {
        return value * 1e3
    }
    
    /// Returns the weight as microgram
    func microgram() -> Double {
        return value * 1e6
    }
    
    /// Returns the weight as gram string
    func gramString() -> String {
        return String(format: "%.2f g", self.gram())
    }
    
    /// Returns the weight as milligram string
    func milligramString() -> String {
        return String(format: "%.2f mg", self.milligram())
    }
    
    /// Returns the weight as microgram string
    func microgramString() -> String {
        return String(format: "%.2f μg", self.microgram())
    }
    
    /// Returns the weight in a proper formatting as metric weight unit
    func metricString() -> String {
        // check for microgram
        if self.value < 5e-4 {
            return microgramString()
        } else if self.value < 5e-1 {
            return milligramString()
        } else {
            return gramString()
        }
    }
}

/// Volume unit
struct Volume: Hashable, Codable {
    /// The volume expressed in litre
    var value: Double
    
    public init(millilitre: Double) {
        value = millilitre * 1e-3
    }
    
    /// Returns the volume as litre
    func litre() -> Double {
        return value
    }
    
    /// Returns the volume as millilitre
    func millilitre() -> Double {
        return value * 1e3
    }
    
    /// Returns the volume as millilitre string
    func millilitreString() -> String {
        return String(format: "%.2f ml", self.millilitre())
    }
    
    /// Returns the volume as litre string
    func litreString() -> String {
        return String(format: "%.2f ml", self.litre())
    }
    
    /// Returns the weight in a proper formatting as metric weight unit
    func metricString() -> String {
        // check for microgram
        if self.value < 5e-1 {
            return millilitreString()
        } else {
            return litreString()
        }
    }
}
