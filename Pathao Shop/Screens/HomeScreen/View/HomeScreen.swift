//
//  HomeScreen.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 21/12/22.
//

import UIKit

class HomeScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var ViewModel: HomeScreenViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _initViewModel()
    }
    
    private func _initViewModel() {
        ViewModel = HomeScreenViewModel()
        tableView.delegate = self
        tableView.register(PathaoShopList.nib, forCellReuseIdentifier: PathaoShopList.identifier)
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        NotificationCenter.default.addObserver(self, selector: #selector(addCound(notification:)), name: .addCount, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeCount(notification:)), name: .removeCount, object: nil)
        setupNavigationBarButtonItem()
    }
    
    func setupNavigationBarButtonItem() {
        let button =  UIButton(type: .custom)
        button.backgroundColor  = UIColor.red
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
        button.layer.cornerRadius = 8
        let label = UILabel(frame: CGRect(x: 3, y: 5, width: 20, height: 20))
//        label.font = UIFont(name: "Arial-BoldMT", size: 16)
        if let vm = ViewModel {
            button.setTitle("\(vm.totalAddItems)", for: .normal)

        }
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
}

