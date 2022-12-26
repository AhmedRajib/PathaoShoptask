//
//  StoreScreen.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit

class StoreScreen: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    var selectedItemLists: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupUI()
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    private func _setupUI() {
        getSelectedInfo()
        tableview.dataSource = self
        tableview.register(StoreScreenCell.nib, forCellReuseIdentifier: StoreScreenCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalPrice(notification:)), name: .totalPrice, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addItemFromStorage(notification:)), name: .addItemFromStoreScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeItemFromStorage(notification:)), name: .removeItemFromStoreScreen, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .totalPrice, object: nil)
        NotificationCenter.default.removeObserver(self, name: .addItemFromStoreScreen, object: nil)
        NotificationCenter.default.removeObserver(self, name: .removeItemFromStoreScreen, object: nil)
    }
    
    func getSelectedInfo() {
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value.count ?? 0 > 0 {
                        selectedItemLists.append(shopItem[index])
                    }
                }
            }
        }
        tableview.reloadData()
    }
    
    @objc func updateTotalPrice(notification: Notification) {
        totalPriceLabel.text = "Total Price: \(Constant.totalItemPrice)"
    }
    
    func updateSelectedItem(searchItem: Item,operationType: AddOrRemove) {
        for (index,item) in selectedItemLists.enumerated() {
            if item == searchItem {
                if operationType == .add {
                    selectedItemLists[index].count! += 1
                } else {
                    if selectedItemLists[index].count ?? 0 > 1 {
                        selectedItemLists[index].count! -= 1
                    }else {
                        selectedItemLists.remove(at: index)
                    }
                }
                tableview.reloadData()
            }
        }
    }

    @objc func addItemFromStorage(notification: Notification) {
        if let selectedItem = (notification.object as? Item) {
            updateSelectedItem(searchItem: selectedItem, operationType: .add)
        }
    }
    
    @objc func removeItemFromStorage(notification: Notification) {
        if let selectedItem = (notification.object as? Item) {
            updateSelectedItem(searchItem: selectedItem, operationType: .remove)
        }
    }
}
