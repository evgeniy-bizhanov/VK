//
//  Friend.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct Friend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int
}

extension Friend {
    enum DecodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case online
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.online = try container.decode(Int.self, forKey: .online)
    }
}
