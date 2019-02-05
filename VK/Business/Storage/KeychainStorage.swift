//
//  KeychainStorage.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import KeychainAccess

extension Keychain: KeyValueStorage {
    func string(forKey key: String) -> String? {
        guard let result = try? get(key) else { return nil }
        return result
    }
    
    func set(value: String, forKey key: String) {
        do {
            try set(value, key: key)
        } catch { }
    }
}
