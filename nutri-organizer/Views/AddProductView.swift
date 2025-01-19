//
//  AddProductView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 18.01.25.
//

import SwiftUI

struct AddProductView: View {
    var productInfo: ProductInfo
    
    var body: some View {
        VStack() {
            Text(productInfo.name).font(.title)
            Image(systemName: "photo").resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
                .padding()
            
            NutrientsView(nutrients: productInfo.nutrients)
        }
        .padding()
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var productInfo = InMemoryProducts().products[0]
    
    static var previews: some View {
        AddProductView(productInfo: productInfo)
    }
}
