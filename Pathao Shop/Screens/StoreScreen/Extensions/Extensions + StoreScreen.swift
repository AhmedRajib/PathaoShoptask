//
//  Extensions + StoreScreen.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 26/12/22.
//

import Foundation
import UIKit

extension StoreScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedItemLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreScreenCell.identifier, for: indexPath) as! StoreScreenCell
        cell.item = selectedItemLists[indexPath.row]
        cell.removeBtn.tag = indexPath.row
        cell.addBtn.tag = indexPath.row
        return cell
    }
    
    
}
