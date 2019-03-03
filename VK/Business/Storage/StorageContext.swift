//
//  StorageContext.swift
//  VK
//
//  Created by Евгений Бижанов on 26/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import RealmSwift

protocol StorageContext {
    func save<T: Object>(_ object: T) throws
    func save<T: Sequence>(_ objects: T) throws where T.Iterator.Element: Object
    
    func fetch<T: Object>(_ objectType: T.Type) -> Results<T>
}
