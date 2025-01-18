//
//  Utils.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 17.01.25.
//

import Foundation

import UIKit

/// Loads an image form the given base64 encoded image string of the form
/// data:image/jpeg;base64,iVBORw0K...
func loadImageFromBase64(base: String) throws -> UIImage {
    // We expect a base64 string like data:image/jpeg;base64,iVBORw0K...
    
    // First, check and remove the data: prefix if available
    var s: Substring
    if !base.starts(with: "data:") {
        let r = base.range(of: "data:")!
        
        s = base[r.upperBound...]
    } else {
        s = base[base.startIndex...]
    }
    
    // Next check for the ;base64,
    if let r = s.range(of: ";base64,") {
        s = s[r.upperBound...]
    } else {
        throw Base64ImageLoading.missingBase64Keyword
    }
    
    // Decode base64 string
    if let imageData = Data(base64Encoded: String(s), options: .ignoreUnknownCharacters) {
        if let image = UIImage(data: imageData) {
            return image
        } else {
            throw Base64ImageLoading.invalidImageData
        }
    } else {
        throw Base64ImageLoading.invalidBase64Data
    }
}
