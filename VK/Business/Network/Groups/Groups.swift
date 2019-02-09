//
//  Groups.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct Group: Decodable {
    let id: Int
    let name: String
    let photoLow: String
    let photoMedium: String
    let photoHigh: String
}

extension Group {
    enum DecodingKeys: String, CodingKey {
        case id
        case name
        case photoLow = "photo_50"
        case photoMedium = "photo_100"
        case photoHigh = "photo_200"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoLow = try container.decode(String.self, forKey: .photoLow)
        self.photoMedium = try container.decode(String.self, forKey: .photoMedium)
        self.photoHigh = try container.decode(String.self, forKey: .photoHigh)
    }
}
