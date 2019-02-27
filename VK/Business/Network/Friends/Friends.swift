//
//  Friend.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct Person: BidirectionalMappable {
    let id: Int
    let firstName: String
    let lastName: String
    let image: String
    let online: Int
}

extension Person {
    enum DecodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "photo_100"
        case online
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        image = try container.decode(String.self, forKey: .image)
        online = try container.decode(Int.self, forKey: .online)
    }
}
