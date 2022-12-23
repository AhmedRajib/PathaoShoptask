//
//  Extensions.swift
//  Pathao Shop
//
//  Created by Ahmed Rajib on 21/12/22.
//

import Foundation
import UIKit
extension HomeScreen: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ViewModel?.productLists.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PathaoShopList.identifier, for: indexPath) as! PathaoShopList
        
        if let shopList = ViewModel?.productLists[indexPath.section] {
            if let item = shopList.items {
                cell.shopItems = []
                cell.shopItems.append(contentsOf: item)
            }
        }
        return cell
    }
}

extension HomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(360)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ViewModel?.productLists[section].shopName
    }
}
