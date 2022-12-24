//
//  Model.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 21/12/22.
//

import Foundation

// MARK: - ShopMoodel
struct ShopMoodel: Codable {
    var shopName: String?
    var items: [Item]?

    enum CodingKeys: String, CodingKey {
        case shopName = "shop_name"
        case items
    }
}

// MARK: - Item
struct Item: Codable,Equatable {
    var name, itemDescription: String?
    var price: Int?
    var image: String?
    var count: Int?
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        if lhs.name == rhs.name && lhs.itemDescription == rhs.itemDescription && lhs.price == rhs.price {
            return true
        }
        return false
    }

    enum CodingKeys: String, CodingKey {
        case name
        case itemDescription = "description"
        case price, image, count
    }
}
