//
//  Error.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 17.01.25.
//

import Foundation

enum Base64ImageLoading: Error {
    case missingBase64Keyword
    case invalidBase64Data
    case invalidImageData
}
