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
//        tableView.sid
    }
}

