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
    let nextFrom: String?
}

extension ResponseData {
    enum CodingKeys: String, CodingKey {
        case count
        case items
        case nextFrom = "next_from"
    }
}
