//
//  Friend.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Foundation
import UIKit

final class VMPerson: Decodable, CustomStringConvertible {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var image: String = ""
    var isOnline: Bool = false
    
    var description: String {
        return lastName
    }
}


// MARK: - Extensions


// MARK: Decodable

extension VMPerson {
    
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
