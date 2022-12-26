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
    var viewmodel = HomeScreenViewModel.shared
    
    @IBAction func BtnTapped(_ sender: UIButton) {
        
        Constant.showScreenFrom = .categoryScreen
        
        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        let vc: CategoryListScreen = storyboard.instantiateViewController(withIdentifier: "CategoryListScreen") as! CategoryListScreen
        let currentController = self.getCurrentViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.selectedSectionTitle = titleLabel.text ?? ""
        currentController?.present(vc, animated: false, completion: nil)
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
    
    func getCurrentViewController() -> UIViewController? {

       if let rootController = UIApplication.shared.keyWindow?.rootViewController {
           var currentController: UIViewController! = rootController
           while( currentController.presentedViewController != nil ) {
               currentController = currentController.presentedViewController
           }
           return currentController
       }
       return nil
   }
    
    func getSelectedItem() -> [Item] {
        for (index,value) in HomeScreenViewModel.productLists.enumerated() {
            if let title = titleLabel.text {
                if value.shopName == title {
                    return HomeScreenViewModel.productLists[index].items ?? []
                }
            }
        }
        return []
    }
}
