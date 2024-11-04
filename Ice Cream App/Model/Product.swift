//
//  Products.swift
//  Ice Cream App
//
//  Created by Muhamad Septian Nugraha on 03/11/24.
//

import Foundation

struct Product: Hashable {
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
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name &&
               lhs.price == rhs.price &&
               lhs.imageURL == rhs.imageURL
    }
}

