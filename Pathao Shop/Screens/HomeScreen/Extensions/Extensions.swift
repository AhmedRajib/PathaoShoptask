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

// MARK: - SET Protocol
extension HomeScreen {
    
   @objc func addCound(notification: Notification) {
//        print(notification.object ?? "") //myObject
//        print(notification.userInfo ?? "") //[AnyHashable("key"): "Value"]
       let selectedItem = (notification.object as? Item)!
       debugPrint("SelectedItem ", selectedItem)
       searchElephantIndex(searchItem: selectedItem)
    }
    
    func searchElephantIndex(searchItem: Item)  {
        for item in ViewModel?.productLists ?? [] {
            for var i in item.items ?? [] {
                if i == searchItem {
//                    var updateValue = searchItem
//                    updateValue.count! += 1
//                    i = updateValue
////                    ViewModel?.productLists
//                    if let count = i.count {
//                        count += 1
//                    }
                    
//                    debugPrint("Srach ", item.items?[i])
//                    for products in ViewModel?.productLists ?? [] {
//                        products.items?.firstIndex(where: {
//                            $0 == searchItem
//                            debugPrint("IndexOfSeachItem ", $0)
//                            return true
//                        })
//                    }
//                    i = searchItem
//                    debugPrint("updated Data ", i.count)
//                    debugPrint("MainData ", ViewModel?.productLists)
                  
//                    for infor in vm.storeItems {
//                       if info == searchItem {
//                           vm.
//                        }
//                    }
//                    vm.storeItems.enumerated().forEach { (index, value) in
//                        if value == searchItem {
//                            vm.storeItems[index].count! += 1
//                            debugPrint("OOKKK ", vm.storeItems)
//                        }else {
//                            vm.storeItems.append(searchItem)
//                            debugPrint("valueLIst ", vm.storeItems)
//                        }
//                    }
                    var infoe = ViewModel?.productLists
                    var inde = 0
                    for shopItemList in ViewModel?.productLists ?? [] {
                        if var shopItem = shopItemList.items {
                            for (index,value) in shopItem.enumerated() {
                                if value == searchItem {
                                    ViewModel?.productLists[inde].items?[index].count! += 1
//                                    shopItemList.items?[index].count! += 1
                                    print("ShopItem ",shopItem, " inde",inde)
                                }
                            }
                        }
                        inde += 1
                    }
                    print("Finally ",ViewModel?.productLists )
                   
                    tableView.reloadData()
                    NotificationCenter.default.post(name: .reloadCollectionView, object: nil)
                }
            }
        }
    }
}
