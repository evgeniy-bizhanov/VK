//
//  Response.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct Response<T: Decodable>: Decodable {
    let response: ResponseData<T>
}

struct ResponseData<T: Decodable>: Decodable {
    let count: Int
    let items: [T]
}
