//
//  RealmStorageContext.swift
//  VK
//
//  Created by Евгений Бижанов on 26/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import RealmSwift

class RealmStorageContext: StorageContext {
    
    // MARK: - Properties
    // MARK: - Fields
    
    private var db: Realm?
    
    
    // MARK: - Functions
    
    func save<T: Object>(_ object: T) throws {
        
        guard let db = db else {
            preconditionFailure("DB context not defined")
        }
        
        try DispatchQueue.main.sync {
            try db.write {
                db.add(object, update: true)
            }
        }
    }
    
    func save<T: Sequence>(_ objects: T) throws where T.Iterator.Element: Object {
        guard let db = db else {
            preconditionFailure("DB context not defined")
        }
        
        try DispatchQueue.main.sync {
            try db.write {
                db.add(objects, update: true)
            }
        }
    }
    
    func fetch<T: Object>(_ : T.Type) -> Results<T> {
        guard let db = db else {
            preconditionFailure("DB context not defined")
        }
        
        return db.objects(T.self)
    }
    
    
    // MARK: - Initializers
    
    init(db: Realm?) {
        self.db = db
    }
}
