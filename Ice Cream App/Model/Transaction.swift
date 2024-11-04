//
//  Transactio.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import UIKit

struct TransactionDetail {
    var id: String
    var productCount: Int
    var totalPrice: Double
    var products: [ProductDetail]
    var createdAt: Date
}

struct ProductDetail: Hashable {
    var name: String
    var price: Double
    var imageURL: String

    // Mengimplementasikan Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(price)
        hasher.combine(imageURL)
    }

    // Implementasi Equatable untuk memeriksa kesetaraan
    static func == (lhs: ProductDetail, rhs: ProductDetail) -> Bool {
        return lhs.name == rhs.name &&
               lhs.price == rhs.price &&
               lhs.imageURL == rhs.imageURL
    }
}
