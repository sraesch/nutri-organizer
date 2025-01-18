//
//  ContentView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 12.01.25.
//

import OSLog
import SwiftUI
import VisionKit

struct ContentView: View {
    @State var showScanner: Bool = false
    @State var productInfo: ProductInfo?

    var body: some View {
        if showScanner {
            ScannerView() {
                p in if let productId = p {
                    Logger.views.info("ContentView: \(productId.idString())")
                    
                    Task {
                        let info: ProductInfo? = await getProductInfo(productId: productId)
                        if let info = info {
                            productInfo = info
                        } else {
                            Logger.views.info("Could not find product for \(productId.idString())")
                        }
                    }
                } else {
                    Logger.views.info("ContentView: No payload")
                }
                
                showScanner = false
            }
        } else {
            Button("Scan Code") {
                Logger.views.debug("Button: Scan Code pressed")
                if !showScanner {
                    showScanner = true
                } else {
                    Logger.views.error("Scanner is still active!!!")
                }
            }
        }
        
        if let productInfo = productInfo {
            if !showScanner {
                ProductCardView(productInfo: productInfo)
            }
        }
    }
    
    func getProductInfo(productId: ProductID) async -> ProductInfo? {
        return await backend().products.product(id: productId)
    }
}

#Preview {
    ContentView()
}
