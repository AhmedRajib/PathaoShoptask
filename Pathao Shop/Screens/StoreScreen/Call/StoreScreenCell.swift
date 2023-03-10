//
//  StoreScreenCell.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit

class StoreScreenCell: UITableViewCell {
    
    @IBOutlet weak var imagePreView: UIImageView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var item: Item? {
        didSet {
            _initView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        debugPrint("Update file ",Constant.totalItemPrice)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func _initView() {
        imagePreView.layer.cornerRadius = 10
        imagePreView.contentMode = .scaleToFill
        if let imageURL = item?.image {
            self.imagePreView.sd_setImage(with: URL(string: imageURL), placeholderImage: nil, options: .continueInBackground)
        }
        if let name = item?.name {
            nameLabel.text = name
        }
        
        if let count = item?.count {
            totalCountLabel.text = "Total Count: \(count)"
            if let price = item?.price {
                totalPriceLabel.text = "Total price: \(price * count)"
                Constant.totalItemPrice += price * count
                
                NotificationCenter.default.post(name: .totalPrice, object: nil)
            }
        
//        if let count = item?.count {
//            totalCountLabel.text = "Total Count: \(count)"
//            if let price = item?.price {
//                totalPriceLabel.text = "Total price: \(price * count)"
//                if Constant.setupDone && !Constant.successfullyAdded{
//                    Constant.totalItemPrice += price
//                    Constant.successfullyAdded = true
//
//                }else {
//                    Constant.totalItemPrice += price * count
//                }
//                NotificationCenter.default.post(name: .totalPrice, object: nil)
//            }
//        }
        }
        addBtn.layer.borderWidth = 1
        addBtn.layer.borderColor = UIColor.black.cgColor
        addBtn.setTitle("Add", for: .normal)
        
        removeBtn.layer.borderWidth = 1
        removeBtn.layer.borderColor = UIColor.black.cgColor
        removeBtn.setTitle("Remove", for: .normal)
        
        
    }

    @IBAction func tappedOnRemoved(_ sender: UIButton) {
        if let item {
            addItem(searchItem: item, operationType: .remove)
            if let price = item.price {
                Constant.totalItemPrice = 0
//                Constant.setupDone = true
//                Constant.successfullyAdded = false
            }
            NotificationCenter.default.post(name: .removeItemFromStoreScreen, object: item)
        }
    }
    
    
    
    @IBAction func tappedOnAdd(_ sender: UIButton) {
        if let item {
            addItem(searchItem: item, operationType: .add)
            if let price = item.price {
                Constant.totalItemPrice = 0
                Constant.setupDone = true
                Constant.successfullyAdded = false
            }
            NotificationCenter.default.post(name: .addItemFromStoreScreen, object: item)
        }
    }
    
    func addItem(searchItem: Item, operationType: AddOrRemove) {
        var inde = 0
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == searchItem {
                        if operationType == .add {
                            HomeScreenViewModel.productLists[inde].items?[index].count! += 1
                            HomeScreenViewModel.totalAddItems += 1
                        }else {
                            if (HomeScreenViewModel.productLists[inde].items?[index].count!)! > 0 {
                                HomeScreenViewModel.productLists[inde].items?[index].count! -= 1
                                HomeScreenViewModel.totalAddItems -= 1
                            }
                            
                        }
                    }
                }
            }
            inde += 1
        }
        NotificationCenter.default.post(name: .reloadCollectionView, object: nil)
    }
   
    
}
