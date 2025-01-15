//
//  ProductsView.swift
//  nutri-organizer
//
//  Created by Sascha Räsch on 15.01.25.
//

import SwiftUI

struct ProductsView: View {
    @State private var searchString: String = ""
    @State private var productInfos: [ProductInfo] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(productInfos, id: \.id) { productInfo in
                    NavigationLink {
                        Text(productInfo.name)
                    } label: {
                        ProductCardView(productInfo: productInfo)
                    }
                }
            }
            .navigationTitle(String(localized: "products"))
            .animation(.default, value: productInfos)
        }
        .searchable(text: $searchString)
        .task(id: searchString) {
            await updateProductInfos()
        }
    }
    
    private func updateProductInfos() async {
        productInfos = await backend().products.search(query: ProductQuery(search: searchString, limit: 40))
    }
}

#Preview {
    ProductsView()
}
