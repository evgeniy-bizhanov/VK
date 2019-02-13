//
//  PersonViewItem.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

enum PointViewType: String, TableViewItemType {
    case online = "онлайн"
    case offline = "прочие"
}

struct PersonViewItem: AbstractTableViewItem {
    
    // MARK: - Properties
    
    var type: TableViewItemType
    var collection: [String]
    var rowCount: Int {
        return collection.count
    }
    
    
    // MARK: - Fields
    // MARK: - Functions
    // MARK: - Initializers
    
    init?(_ type: PointViewType, withValues collection: [String]) {
        guard collection.count > 0 else { return nil }
        
        self.type = type
        self.collection = collection
    }
}
