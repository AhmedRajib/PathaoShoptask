//
//  Extension + NotificationCenter.swift
//  Pathao Shop
//
//  Created by MacBook Pro on 24/12/22.
//

import Foundation
extension NSNotification.Name {

    public static let addCountFromHomeScreen = NSNotification.Name("addCountFromHomeScreen")
    public static let removeCountFromHomeScreen = NSNotification.Name("removeCountFromHomeScreen")
    public static let addCountFromCategoryScreen = NSNotification.Name("addCountFromCategoryScreen")
    public static let removeCountFromCategoryScreen = NSNotification.Name("removeCountFromCategoryScreen")
    
    public static let reloadCollectionView = NSNotification.Name("reloadCollectionView")

}
