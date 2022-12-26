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
        HomeScreenViewModel.productLists.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PathaoShopList.identifier, for: indexPath) as! PathaoShopList
        
         let shopList = HomeScreenViewModel.productLists[indexPath.section] // {
            if let item = shopList.items {
                cell.shopItems = []
                cell.shopItems.append(contentsOf: item)
            }
        return cell
    }
}

extension HomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView()
        headerView.titleLabel.text = HomeScreenViewModel.productLists[section].shopName
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
        if let selectedItem = (notification.object as? Item) {
            removeItem(searchItem: selectedItem)
        }
     }
    
    func searchElephantIndex(searchItem: Item) {
        var inde = 0
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == searchItem {
                        if (HomeScreenViewModel.productLists[inde].items?[index].count!)! < 5 {
                            HomeScreenViewModel.productLists[inde].items?[index].count! += 1
//                            ViewModel?.totalAddItems += 1
                            HomeScreenViewModel.totalAddItems += 1
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
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == searchItem {
                        if(HomeScreenViewModel.productLists[inde].items?[index].count!)! > 0{
                            HomeScreenViewModel.productLists[inde].items?[index].count! -= 1
                            HomeScreenViewModel.totalAddItems -= 1
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
    
    @objc func reloadTableView(notification: Notification) {
        tableView.reloadData()
        print(" twoo TableViewReload")
    }
    
    @objc func buttonAction() {
        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        let vc: StoreScreen = storyboard.instantiateViewController(withIdentifier: "StoreScreen") as! StoreScreen
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
