//
//  ScannerView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 18.01.25.
//

import SwiftUI
import OSLog

struct ScannerView: View {
    var action: (ProductID?) -> Void
    
    var body: some View {
        ScannerControllerView() { payload in
            if let payload = payload {
                Logger.views.info("Got payload \(payload.idString())")
                action(payload)
            } else {
                Logger.views.info("No payload received")
                action(nil)
            }
        }
    }
}

#Preview {
    ScannerView() {
        p in if let payload = p {
            print("Payload: \(payload.idString())")
        }
    }
}
