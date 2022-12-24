//
//  CustomHeaderView.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 25/12/22.
//

import UIKit

class CustomHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func BtnTapped(_ sender: UIButton) {
        debugPrint("SelectedItemsss",titleLabel.text)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        loadNib()
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("CustomHeaderView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
