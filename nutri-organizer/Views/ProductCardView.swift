//
//  ProductCardView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import SwiftUI
import OSLog

struct ProductCardView: View {
    var productInfo: ProductInfo
    
    var image: Image? {
        if let img = loadPreviewImage() {
            img
        } else {
            nil
        }
    }
    
    var body: some View {
        HStack {
            if let image = image {
                image.resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 50, height: 50)
            } else {
                Image(systemName: "photo").resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.secondary)
            }
            
            VStack(alignment: .leading) {
                Text(productInfo.name)
                    .font(.headline)
                Spacer()
                HStack {
                    Label("\(productInfo.nutrients.quantity.metricString())", systemImage: "scalemass")
                    Spacer()
                    Label("\(Int(productInfo.nutrients.kcal.rounded())) kcal", systemImage: "flame")
                }
                .font(.caption).foregroundColor(.accentColor)
            }
            .padding()
            
            
        }
    }
    
    /// Helper function to load the preview image if defined
    private func loadPreviewImage() -> Image? {
        if let preview = productInfo.preview {
            do {
                let image = try loadImageFromBase64(base: preview)
                Logger.views.trace("Created preview image \(image.size.width)x\(image.size.height)")
                
                return Image(uiImage: image)
            } catch Base64ImageLoading.invalidBase64Data {
                Logger.views.error("Failed creating preview \(productInfo.id.idString()); Image Base64 data were invalid")
                return nil
            } catch Base64ImageLoading.invalidImageData {
                Logger.views.error("Failed creating preview \(productInfo.id.idString()); Image data were invalid")
                return nil
            } catch Base64ImageLoading.missingBase64Keyword {
                Logger.views.error("Failed creating preview \(productInfo.id.idString()); Missing base64 keyword")
                return nil
            } catch {
                Logger.views.error("Failed creating preview \(productInfo.id.idString()); Unknown error")
                return nil
            }
        } else {
            return nil
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var productInfo = InMemoryProducts().products[0]
    
    static var previews: some View {
        ProductCardView(productInfo: productInfo)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
