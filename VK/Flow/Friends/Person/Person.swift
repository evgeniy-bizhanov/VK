//
//  Friend.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct VMPerson: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let isOnline: Bool
}

extension VMPerson {
    
    enum DecodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case isOnline = "online"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        isOnline = try container.decode(Int.self, forKey: .isOnline) > 0
    }
}
