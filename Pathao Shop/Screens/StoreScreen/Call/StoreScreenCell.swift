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
            
        }
        
        
    }

    @IBAction func tappedOnRemoved(_ sender: UIButton) {
        print("removedItem ", sender.tag)
        debugPrint("Selectiiiii ",item)
//        NotificationCenter.default.post(name: .totalPrice, object: nil)
        NotificationCenter.default.post(name: .removeItemFromStoreScreen, object: item)
    }
    
    
    
    @IBAction func tappedOnAdd(_ sender: UIButton) {
        print("removedItem ", sender.tag)
//        NotificationCenter.default.post(name: .totalPrice, object: nil)
        if let item {
            addItem(searchItem: item)
            NotificationCenter.default.post(name: .addItemFromStoreScreen, object: item)
        }
    }
    
    func addItem(searchItem: Item) {
        var inde = 0
        for shopItemList in HomeScreenViewModel.productLists {
            if let shopItem = shopItemList.items {
                for (index,value) in shopItem.enumerated() {
                    if value == searchItem {
//                        if (HomeScreenViewModel.productLists[inde].items?[index].count!)! < 5 {
//                            HomeScreenViewModel.productLists[inde].items?[index].count! += 1
////                            ViewModel?.totalAddItems += 1
//                            HomeScreenViewModel.totalAddItems += 1
//                        }
                        HomeScreenViewModel.productLists[inde].items?[index].count! += 1
//                            ViewModel?.totalAddItems += 1
                        HomeScreenViewModel.totalAddItems += 1
                    }
                }
            }
            inde += 1
        }
        NotificationCenter.default.post(name: .reloadCollectionView, object: nil)
    }
   
    
}
