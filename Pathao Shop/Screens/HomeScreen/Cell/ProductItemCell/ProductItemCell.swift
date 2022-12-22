//
//  ProductItemCell.swift
//  Pathao Shop
//
//  Created by Ahmed Rajib on 21/12/22.
//

import UIKit

class ProductItemCell: UICollectionViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initView()
    }
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    private func initView() {
        
    }
    @IBAction func AddBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func removeBtnTapped(_ sender: UIButton) {
    }
}
