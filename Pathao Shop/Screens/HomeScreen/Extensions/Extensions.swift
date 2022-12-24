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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView()
        headerView.titleLabel.text = ViewModel?.productLists[section].shopName
        return headerView
    }
}

// MARK: - SET Protocol
extension HomeScreen {
    
   @objc func addCound(notification: Notification) {
       let selectedItem = (notification.object as? Item)!
       searchElephantIndex(searchItem: selectedItem)
    }
    
    @objc func removeCount(notification: Notification) {
        let selectedItem = (notification.object as? Item)!
        removeItem(searchItem: selectedItem)
     }
    
    func searchElephantIndex(searchItem: Item)  {
        var inde = 0
        for shopItemList in ViewModel?.productLists ?? [] {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == searchItem {
                        if (ViewModel?.productLists[inde].items?[index].count!)! < 5{
                            ViewModel?.productLists[inde].items?[index].count! += 1
                            ViewModel?.totalAddItems += 1
                            setupNavigationBarButtonItem()
                        }
                    }
                }
            }
            inde += 1
        }       
        tableView.reloadData()
        NotificationCenter.default.post(name: .reloadCollectionView, object: nil)
    }
    
    func removeItem(searchItem: Item)  {
        var inde = 0
        for shopItemList in ViewModel?.productLists ?? [] {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == searchItem {
                        if (ViewModel?.productLists[inde].items?[index].count!)! > 0{
                            ViewModel?.productLists[inde].items?[index].count! -= 1
                            ViewModel?.totalAddItems -= 1
                            setupNavigationBarButtonItem()
                        }
                    }
                }
            }
            inde += 1
        }
        tableView.reloadData()
        NotificationCenter.default.post(name: .reloadCollectionView, object: nil)
    }
    
    @objc func buttonAction() {
        
    }
}
