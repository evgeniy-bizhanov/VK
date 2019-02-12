//
//  Photos.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct Photo: BidirectionalMappable {
    let id: Int
    let sizes: [PhotoSize]
    let text: String
}

struct PhotoSize: BidirectionalMappable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
