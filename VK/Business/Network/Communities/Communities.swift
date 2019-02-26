//
//  Groups.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import RealmSwift

@objcMembers
final class Community: Object, BidirectionalMappable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var photoLow: String = ""
    dynamic var photoMedium: String = ""
    dynamic var photoHigh: String = ""
}

extension Community {
    enum DecodingKeys: String, CodingKey {
        case id
        case name
        case photoLow = "photo_50"
        case photoMedium = "photo_100"
        case photoHigh = "photo_200"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoLow = try container.decode(String.self, forKey: .photoLow)
        self.photoMedium = try container.decode(String.self, forKey: .photoMedium)
        self.photoHigh = try container.decode(String.self, forKey: .photoHigh)
    }
}
