//
//  HomeScreen.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 21/12/22.
//

import UIKit

class HomeScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       let jsonFile = loadJson(filename: "pathao-shop")
        if let json = jsonFile {
            debugPrint("User Info ",json)
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

