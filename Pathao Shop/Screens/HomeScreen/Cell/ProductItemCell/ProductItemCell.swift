//
//  ProductItemCell.swift
//  Pathao Shop
//
//  Created by Ahmed Rajib on 21/12/22.
//

import UIKit
import SDWebImage

protocol setCount {
    func addItem(item: Item)
    func removeItem(item: Item)
}

class ProductItemCell: UICollectionViewCell {

     // MARK: - OUTLETS CONNECTIONS
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    @IBOutlet weak var backView: UIView!
    // MARK: - VARIABLE SECTIONS
    var item: Item? {
        didSet {
            initView()
        }
    }
    var delegate: setCount?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    private func initView() {
        addBtn.backgroundColor = UIColor.clear
        addBtn.layer.borderColor = UIColor.black.cgColor
        addBtn.layer.borderWidth = 1
        
        removeBtn.backgroundColor = UIColor.clear
        removeBtn.layer.borderColor = UIColor.black.cgColor
        removeBtn.layer.borderWidth = 1
        backView.layer.cornerRadius = 6
        image.layer.cornerRadius = 10
        if let shopItem = item {
            nameLabel.text = shopItem.name
            descriptionLabel.text = shopItem.itemDescription
            if let price = item?.price {
                priceLabel.text = "\(price)"
            }
            image.backgroundColor = .lightGray
            image.contentMode = .scaleAspectFill
            if let imageUrl = shopItem.image {
                self.image.sd_setImage(with: URL(string: imageUrl), placeholderImage: nil, options: .continueInBackground)
            }
            if let count = item?.count {
                countLabel.text = "\(count)"
            }
        }
    }
    @IBAction func AddBtnTapped(_ sender: UIButton) {
        if let addItem = item {
            debugPrint("CurrentSta ",Constant.showScreenFrom)
            switch Constant.showScreenFrom {
            case .homeScreen:
                NotificationCenter.default.post(name: .addCountFromHomeScreen, object: addItem)
            case .categoryScreen:
                NotificationCenter.default.post(name: .addCountFromCategoryScreen, object: addItem)
            case .storeScreen:
                debugPrint("Hello")
            }
        }
    }
    
    @IBAction func removeBtnTapped(_ sender: UIButton) {
        if let addItem = item {
            switch Constant.showScreenFrom {
            case .homeScreen:
                NotificationCenter.default.post(name: .removeCountFromHomeScreen, object: addItem)
            case .categoryScreen:
                NotificationCenter.default.post(name: .removeCountFromCategoryScreen, object: addItem)
            case .storeScreen:
                debugPrint("removed")
            }
        }
    }
}
