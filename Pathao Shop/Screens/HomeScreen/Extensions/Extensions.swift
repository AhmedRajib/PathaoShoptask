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
        debugPrint("XYQ ",ViewModel?.productLists.count ?? 0)
       return ViewModel?.productLists.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("total numberOfRowsInSection ",section)
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PathaoShopList.identifier, for: indexPath) as! PathaoShopList
        
        if let shopList = ViewModel?.productLists[indexPath.section] {
            if let item = shopList.items {
                cell.shopItems = []
                cell.shopItems.append(contentsOf: item)
                debugPrint("HEllo ", item)
            }
        }
        return cell
    }
    
    
}

extension HomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(300)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        debugPrint("TitleSectionListqqq  ",section)
//       return ViewModel?.productLists[section].shopName
        return "section \(section)"
    }
}
