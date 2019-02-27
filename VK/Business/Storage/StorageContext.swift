//
//  StorageContext.swift
//  VK
//
//  Created by Евгений Бижанов on 26/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol StorageContext {
    func save<T: Storable>(_ object: T) throws
    func save<T: Sequence>(_ objects: T) throws where T.Iterator.Element: Storable
}
