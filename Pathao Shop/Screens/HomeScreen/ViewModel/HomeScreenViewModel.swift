//
//  HomeScreenViewModel.swift
//  Pathao Shop
//
//  Created by Ahmed Rajib on 21/12/22.
//

import Foundation
//import UIKit

class HomeScreenViewModel {
    var productLists : [ShopMoodel] = []
    var title: [String] = []
    
    init() {
        let jsonFile = loadJson(filename: "pathao-shop")
         if let json = jsonFile {
             productLists = json
//             let hel = json.filter { title in
//                 title.shopName is String
//             }
//             debugPrint("Pathao ", he)
         }

    }
    func loadJson(filename fileName: String) -> [ShopMoodel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([ShopMoodel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
