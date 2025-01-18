//
//  Logging.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 18.01.25.
//

import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs related to the backend
    static let backend: Logger = Logger(subsystem: subsystem, category: "backend")
    
    /// Logs that appears inside the views/components of the UI
    static let views: Logger = Logger(subsystem: subsystem, category: "views")

    /// All logs related to tracking and analytics.
    static let statistics: Logger = Logger(subsystem: subsystem, category: "statistics")
}
