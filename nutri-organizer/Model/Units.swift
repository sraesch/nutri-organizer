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
    
    /// Returns the weight in a proper formatting as metric weight unit
    func metricString() -> String {
        // check for microgram
        if self.value < 5e-4 {
            let microgram = round2(x: self.microgram())
            return "\(microgram) μg"
        } else if self.value < 5e-1 {
            let milligram = round2(x: self.milligram())
            return "\(milligram) mg"
        } else {
            let gram = round2(x: self.gram())
            return "\(gram) g"
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
    
    /// Returns the weight in a proper formatting as metric weight unit
    func metricString() -> String {
        // check for microgram
        if self.value < 5e-1 {
            let ml = round2(x: self.millilitre())
            return "\(ml) ml"
        } else {
            let l = round2(x: self.litre())
            return "\(l) l"
        }
    }
}


/// Helper function to round a value to 2 digits behind the comma
private func round2(x: Double) -> Double {
    return (x * 1e2).rounded() * 1e-2
}
