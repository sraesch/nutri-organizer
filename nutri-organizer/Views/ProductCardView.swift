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
                    .font(.caption)
                }
                .padding()
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var productInfo = ProductInfo(
        id: ProductID.barcode("5411188124689"),
        name: "Haferdrink ungesüßt, 1 Liter",
        producer: "Alpro",
        nutrients: Nutrients(
            kcal: 40.0,
            quantity: Quantity.volume(Volume(millilitre: 100)),
            protein: Weight(gram: 0.2),
            fat: Weight(gram: 1.5),
            carbohydrates: Weight(gram: 5.6),
            sugar: Weight(gram: 0.0),
            salt: Weight(gram: 0.09),
            calcium: Weight(milligram: 120)
        )
    )

    static var previews: some View {
        ProductCardView(productInfo: productInfo)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
