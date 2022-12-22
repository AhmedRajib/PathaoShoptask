//
//  PathaoShopList.swift
//  Pathao Shop
//
//  Created by Ahmed Rajib on 21/12/22.
//

import UIKit

class PathaoShopList: UITableViewCell {

     // MARK: - Outlets connection lists
    @IBOutlet weak var collectionView: UICollectionView!
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
     // MARK: - Variables Lists
    var shopItems = [Item]() {
            didSet {
                collectionView.reloadData()
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func _initView() {
        collectionView.register(ProductItemCell.nib, forCellWithReuseIdentifier: ProductItemCell.identifier)

//        collectionView.scrold
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView!.contentInset = UIEdgeInsets(top: -10, left: 0, bottom:0, right: 0)
        
//        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.minimumInteritemSpacing = 0
//            layout.minimumLineSpacing = 0
//            layout.itemSize = CGSize(width: self.collectionView.frame.size.width-40, height: self.collectionView.frame.size.height-10)
//            layout.invalidateLayout()
//        }
    }
    
}

//  MARK: - Setup DataSource Methods
extension PathaoShopList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.identifier, for: indexPath) as! ProductItemCell
        cell.nameLabel.text = shopItems[indexPath.row].name
//        debugPrint("shopingItem ",shopItems[indexPath.row].name)
        return cell
    }
}

 // MARK: - Setup Delegate Methods
extension PathaoShopList: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250 , height: 250)
    }
    
}
