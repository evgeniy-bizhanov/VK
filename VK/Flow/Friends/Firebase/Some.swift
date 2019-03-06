//
//  Some.swift
//  VK
//
//  Created by Евгений Бижанов on 06/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import FirebaseDatabase

class Some {
    let id: Int
    let description: String
    let ref: DatabaseReference?
    
    init(id: Int, description: String) {
        self.ref = nil
        self.id = id
        self.description = description
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let description = value["description"] as? String else {
                return nil
        }

        self.ref = snapshot.ref
        self.id = id
        self.description = description
    }

    func toDatabase() -> [String: Any] {
        return [
            "id": id,
            "description": description
        ]
    }
}
