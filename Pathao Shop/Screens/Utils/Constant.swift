//
//  Constant.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 25/12/22.
//

import Foundation

enum FromScreen {
    case homeScreen
    case categoryScreen
    case storeScreen
}

enum AddOrRemove {
    case add
    case remove
}

struct Constant {
    static var showScreenFrom: FromScreen = .homeScreen
    static var totalItemPrice = 0

}
