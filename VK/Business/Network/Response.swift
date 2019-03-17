//
//  Response.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct Response<T: BidirectionalMappable>: Decodable {
    let response: ResponseData<T>
}

struct ResponseData<T: BidirectionalMappable>: BidirectionalMappable {
    let count: Int?
    let items: [T]
    let profiles: [Person]?
    let groups: [Community]?
    let newOffset: String?
    let nextFrom: String?
}

extension ResponseData {
    enum DecodingKeys: String, CodingKey {
        case newOffset = "new_offset"
        case nextFrom = "next_from"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decodingContainer = try decoder.container(keyedBy: DecodingKeys.self)
        
        count = try? container.decode(Int.self, forKey: .count)
        items = try container.decode([T].self, forKey: .items)
        profiles = try? container.decode([Person].self, forKey: .profiles)
        groups = try? container.decode([Community].self, forKey: .groups)
        newOffset = try? decodingContainer.decode(String.self, forKey: .newOffset)
        nextFrom = try? decodingContainer.decode(String.self, forKey: .nextFrom)
    }
}
