//
//  KeyValueStorage.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol KeyValueStorage {
    func string(forKey key: String) -> String?
    func set(value: String, forKey key: String)
    func remove(withKey key: String)
}
