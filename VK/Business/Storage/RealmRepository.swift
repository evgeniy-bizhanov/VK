//
//  RealmStorage.swift
//  VK
//
//  Created by Евгений Бижанов on 26/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import RealmSwift

extension Object: Storable {}

class RealmStorageContext: StorageContext {
    
    // MARK: - Properties
    // MARK: - Fields
    
    private var db: Realm?
    
    
    // MARK: - Functions
    
    func fetch<T: Storable>(_ objectType: T.Type, completion: ((T) -> Void)) throws {
        guard
            let db = db,
            let objectType = objectType as? Object.Type else {
                
                preconditionFailure("Expected type `Object` but \(T.self) type received")
        }
        
        let results = db.objects(objectType)
        
        // TODO: Do some cast
    }
    
    func save<T: Storable>(_ object: T) throws {
        
        guard
            let db = db,
            let object = object as? Object else {
                
                preconditionFailure("Expected type `Object` but \(T.self) type received")
        }
        
        try DispatchQueue.main.sync {
            try db.write {
                db.add(object)
            }
        }
    }
    
    func save<T: Sequence>(_ objects: T) throws where T.Iterator.Element: Storable {
        guard
            let db = db,
            let objects = objects as? [Object] else {
                
                preconditionFailure("Expected type `Object` but \(T.self) type received")
        }
        
        try DispatchQueue.main.sync {
            try db.write {
                db.add(objects)
            }
        }
    }
    
    func save<T: Storable>(_ objects: [T]) throws {
        
        
    }
    
    
    // MARK: - Initializers
    
    init(db: Realm?) {
        self.db = db
    }
}
