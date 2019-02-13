//
//  AbstractTableViewItem.swift
//  VK
//
//  Created by Евгений Бижанов on 05/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol AbstractTableViewItem {
    
    /// The type of point section item
    var type: TableViewItemType { get }
    
    /// Count of elements in collection
    var rowCount: Int { get }
    
    /// Section label
    var label: String { get }
    
    /// Collection of items
    var collection: [String] { get }
}

extension AbstractTableViewItem {
    var rowCount: Int { return collection.count }
    var label: String { return type.identifier }
}
