//
//  CategoryListScreen.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 25/12/22.
//

import UIKit

class CategoryListScreen: UIViewController {

    @IBOutlet weak var totalAddedItem: UIButton!
    @IBOutlet weak var collectionview: UICollectionView!
    
    let spacing:CGFloat = 16
    var items: [Item]? {
        didSet {
            collectionview.reloadData()
        }
    }
    var selectedSectionTitle = ""
    var ViewModel: HomeScreenViewModel?
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    private func setupView() {
        ViewModel = HomeScreenViewModel.shared
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(ProductItemCell.nib, forCellWithReuseIdentifier: ProductItemCell.identifier)
        collectionview.collectionViewLayout = collectionViewLayout()

        NotificationCenter.default.addObserver(self, selector: #selector(addCound(notification:)), name: .addCountFromCategoryScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removetemFromList(notification:)), name: .removeCountFromCategoryScreen, object: nil)
        totalAddedItem.layer.cornerRadius = 8
        totalAddedItem.setTitle("\(HomeScreenViewModel.totalAddItems)", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !selectedSectionTitle.isEmpty {
            getSelectedItem(title: selectedSectionTitle)
        }
    }
    
    func getSelectedItem(title: String) {
        for (index,value) in HomeScreenViewModel.productLists.enumerated() {
            if value.shopName == title {
                items = HomeScreenViewModel.productLists[index].items
            }
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        // Important: if direction is horizontal use minimumItemSpacing instead.
        layout.scrollDirection = .vertical
        
        let itemHeight: CGFloat = 240
        let minCellWidth :CGFloat = 130.0
        let minItemSpacing: CGFloat = 10
        let containerWidth: CGFloat = self.view.bounds.width
        let maxCellCountPerRow: CGFloat =  floor((containerWidth - minItemSpacing) / (minCellWidth+minItemSpacing ))
        
        let itemWidth: CGFloat = floor( ((containerWidth - (2 * minItemSpacing) - (maxCellCountPerRow-1) * minItemSpacing) / maxCellCountPerRow  ) )
        // Calculate the remaining space after substracting calculating cellWidth (Divide by 2 because of left and right insets)
        let inset = max(minItemSpacing, floor( (containerWidth - (maxCellCountPerRow*itemWidth) - (maxCellCountPerRow-1)*minItemSpacing) / 2 ) )

        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = min(minItemSpacing,inset)
        layout.minimumLineSpacing = minItemSpacing
        layout.sectionInset = UIEdgeInsets(top: minItemSpacing, left: inset, bottom: minItemSpacing, right: inset)

        
        return layout
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        debugPrint("TotalCounbt ", HomeScreenViewModel.totalAddItems)
        Constant.showScreenFrom = .homeScreen
        dismiss(animated: true)
        {
            NotificationCenter.default.post(name: .reloadCollectionView, object: nil)
        }
    }

}
