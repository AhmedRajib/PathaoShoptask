//
//  Extensions.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 25/12/22.
//

import Foundation
import UIKit

extension CategoryListScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.identifier, for: indexPath) as! ProductItemCell
        cell.item = items?[indexPath.row]
        return cell
    }
}

 // MARK: - Setup Delegate Methods
extension CategoryListScreen: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsperRow = 2
        let spacingbetweencells = 8
    
        let totalSpacing = (2 * Int(self.spacing)) + ((numberOfItemsperRow - 1) * spacingbetweencells)
        if let collection = self.collectionview{
            let width = (Int(collection.bounds.width) - totalSpacing)/numberOfItemsperRow
            return CGSize(width: width , height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}


extension CategoryListScreen {
    @objc func addCound(notification: Notification) {
        let removeItem = (notification.object as? Item)!
        var inde = 0
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == removeItem {
                        if(HomeScreenViewModel.productLists[inde].items?[index].count!)! < 5{
                            HomeScreenViewModel.productLists[inde].items?[index].count! += 1
                            HomeScreenViewModel.totalAddItems += 1
                            self.items = HomeScreenViewModel.productLists[inde].items
                            totalAddedItem.setTitle("\(HomeScreenViewModel.totalAddItems)", for: .normal)
                        }
                    }
                }
            }
            inde += 1
        }

     }
    
    @objc func removetemFromList(notification: Notification) {
        let removeItem = (notification.object as? Item)!
        var inde = 0
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == removeItem {
                        if(HomeScreenViewModel.productLists[inde].items?[index].count!)! > 0 {
                            HomeScreenViewModel.productLists[inde].items?[index].count! -= 1
                            HomeScreenViewModel.totalAddItems -= 1
                            self.items = HomeScreenViewModel.productLists[inde].items
                            totalAddedItem.setTitle("\(HomeScreenViewModel.totalAddItems)", for: .normal)
                        }
                    }
                }
            }
            inde += 1
        }
     }
}
