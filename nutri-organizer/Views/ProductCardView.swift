//
//  ProductCardView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import SwiftUI

struct ProductCardView: View {
    var productInfo: ProductInfo
    
    var body: some View {
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

struct ProductCardView_Previews: PreviewProvider {
    static var productInfo = InMemoryProducts().products[0]
    
    static var previews: some View {
        ProductCardView(productInfo: productInfo)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
