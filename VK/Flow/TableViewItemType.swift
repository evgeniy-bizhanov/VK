//
//  TableViewItemType.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol TableViewItemType: Identifiable {}

extension Identifiable where Self: TableViewItemType {
    var identifier: String {
        return String(describing: self).capitalized + "View"
    }
}
