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
    deinit {
        NotificationCenter.default.removeObserver(self, name: .removeCountFromHomeScreen, object: nil)
        NotificationCenter.default.removeObserver(self, name: .addCountFromHomeScreen, object: nil)
        NotificationCenter.default.removeObserver(self, name: .reloadCollectionView, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupNavigationBarButtonItem()
        setupNavigationBarButtonItem()
    }
    
    private func _initViewModel() {
        ViewModel = HomeScreenViewModel()
        tableView.delegate = self
        tableView.register(PathaoShopList.nib, forCellReuseIdentifier: PathaoShopList.identifier)
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        NotificationCenter.default.addObserver(self, selector: #selector(addCound(notification:)), name: .addCountFromHomeScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeCount(notification:)), name: .removeCountFromHomeScreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(notification:)), name: .reloadCollectionView, object: nil)
        setupNavigationBarButtonItem()
        self.navigationItem.title = "Home Screen"
    }
    
    func setupNavigationBarButtonItem() {
        let button =  UIButton(type: .custom)
        button.backgroundColor  = UIColor.red
        button.addTarget(self, action: #selector(showStorageScreen), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
        button.layer.cornerRadius = 8
        button.setTitle("\(HomeScreenViewModel.totalAddItems)", for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
}

