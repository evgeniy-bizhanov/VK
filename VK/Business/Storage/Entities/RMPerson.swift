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
    dynamic var online: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

//extension RMPerson {
//    enum DecodingKeys: String, CodingKey {
//        case id
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case image = "photo_100"
//        case online
//    }
//
//    convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: DecodingKeys.self)
//        print(container.allKeys)
//
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.firstName = try container.decode(String.self, forKey: .firstName)
//        self.lastName = try container.decode(String.self, forKey: .lastName)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.online = try container.decode(Int.self, forKey: .online)
//    }
//}
