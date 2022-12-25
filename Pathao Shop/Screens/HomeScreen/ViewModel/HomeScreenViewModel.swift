//
//  HomeScreenViewModel.swift
//  Pathao Shop
//
//  Created by Ahmed Rajib on 21/12/22.
//

import Foundation

struct HomeScreenViewModel {
    static var productLists : [ShopMoodel] = []
    static var totalAddItems = 0
    var title: [String] = []
    var storeItem: [Item] = []
    static var shared = HomeScreenViewModel()
    init() {
        let jsonFile = loadJson(filename: "pathao-shop")
         if let json = jsonFile {
             HomeScreenViewModel.productLists = json
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
