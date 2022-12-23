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
    let spacing:CGFloat = 10
    
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

        collectionView?.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        self.collectionView.collectionViewLayout = layout
//        self.collectionView!.contentInset = UIEdgeInsets(top: -10, left: 0, bottom:0, right: 0)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        self.collectionView.collectionViewLayout = layout
    }
    
}

//  MARK: - Setup DataSource Methods
extension PathaoShopList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopItems.count > 5 ? 5 : shopItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.identifier, for: indexPath) as! ProductItemCell
//        cell.nameLabel.text = shopItems[indexPath.row].name
        cell.item = shopItems[indexPath.row]
        return cell
    }
}

 // MARK: - Setup Delegate Methods
extension PathaoShopList: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsperRow = 1
        let spacingbetweencells = 16
        
        
        let totalSpacing = (2 * Int(self.spacing)) + ((numberOfItemsperRow - 1) * spacingbetweencells)
        if let collection = self.collectionView{
            let width = (Int(collection.bounds.width) - totalSpacing)/numberOfItemsperRow
            return CGSize(width: width - 20, height: 350)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
}
