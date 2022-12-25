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
//        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
//        layout.minimumLineSpacing = spacing
//        layout.minimumInteritemSpacing = spacing
//
//        self.collectionView.collectionViewLayout = layout
        self.collectionView.collectionViewLayout = collectionViewLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView(notification:)), name: .reloadCollectionView, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .reloadCollectionView, object: nil)
    }
    @objc func reloadCollectionView(notification: Notification) {
        collectionView.reloadData()
        print(" twoo Reload COllectionview")
     }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        // Important: if direction is horizontal use minimumItemSpacing instead.
        layout.scrollDirection = .vertical
        
        let itemHeight: CGFloat = 240
        let minCellWidth :CGFloat = 130.0
        let minItemSpacing: CGFloat = 10
        let containerWidth: CGFloat = collectionView.bounds.width
        let maxCellCountPerRow: CGFloat =  floor((containerWidth - minItemSpacing) / (minCellWidth+minItemSpacing ))
        
        let itemWidth: CGFloat = floor( ((containerWidth - (2 * minItemSpacing) - (maxCellCountPerRow-1) * minItemSpacing) / maxCellCountPerRow  ) )
        // Calculate the remaining space after substracting calculating cellWidth (Divide by 2 because of left and right insets)
        let inset = max(minItemSpacing, floor( (containerWidth - (maxCellCountPerRow*itemWidth) - (maxCellCountPerRow-1)*minItemSpacing) / 2 ) )

        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = min(minItemSpacing,inset)
        layout.minimumLineSpacing = minItemSpacing
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: minItemSpacing, left: inset, bottom: minItemSpacing, right: inset)

        
        return layout
    }
    
}

//  MARK: - Setup DataSource Methods
extension PathaoShopList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopItems.count > 5 ? 5 : shopItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.identifier, for: indexPath) as! ProductItemCell
        cell.item = shopItems[indexPath.row]
        return cell
    }
}

 // MARK: - Setup Delegate Methods
extension PathaoShopList: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsperRow = 2
        let spacingbetweencells = 8
    
        let totalSpacing = (2 * Int(self.spacing)) + ((numberOfItemsperRow - 1) * spacingbetweencells)
        if let collection = self.collectionView{
            let width = (Int(collection.bounds.width) - totalSpacing)/numberOfItemsperRow
            return CGSize(width: width , height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }

}
