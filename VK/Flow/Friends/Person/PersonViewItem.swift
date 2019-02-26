//
//  PersonViewItem.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

enum PersonViewType: String, TableViewItemType {
    
    var label: String { return self.rawValue }
    
    case online = "Онлайн"
    case offline = "Прочие"
}

struct PersonViewItem: AbstractTableViewItem {
    
    typealias Element = VMPerson
    
    // MARK: - Properties
    
    var type: TableViewItemType
    var label: String?
    var collection: [Element]
    var rowCount: Int {
        return collection.count
    }
    
    
    // MARK: - Fields
    // MARK: - Functions
    // MARK: - Initializers
    
    init?(_ type: PersonViewType, withValues collection: [Element]) {
        guard collection.count > 0 else { return nil }
        
        self.type = type
        self.collection = collection
    }
    
    init?(_ type: PersonViewType, label: String, withValues collection: [Element]) {
        self.init(type, withValues: collection)
        self.label = label
    }
}
