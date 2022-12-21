//
//  Model.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 21/12/22.
//

import Foundation

// MARK: - ShopMoodel
struct ShopMoodel: Codable {
    let shopName: String?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case shopName = "shop_name"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let name, itemDescription: String?
    let price: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case name
        case itemDescription = "description"
        case price, image
    }
}
