//
//  RMPerson.swift
//  VK
//
//  Created by Евгений Бижанов on 27/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import RealmSwift

@objcMembers
final class RMPerson: Object, BidirectionalMappable {
    dynamic var id: Int = 0
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var image: String = ""
    dynamic var isOnline: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var label: String {
        return String(lastName.first ?? firstName.first ?? "#")
    }
    
    func toFirestore() -> [String: Any] {
        return [
            "Id" : id,
            "FirstName": firstName,
            "LastName": lastName
        ]
    }
}

// MARK: Decodable

extension RMPerson {
    
    enum DecodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case image
        case isOnline = "online"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        image = try container.decode(String.self, forKey: .image)
        isOnline = try container.decode(Int.self, forKey: .isOnline) > 0
    }
}
