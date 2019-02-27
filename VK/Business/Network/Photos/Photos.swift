//
//  Photos.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

class Photo: BidirectionalMappable {
    let id: Int
    let sizes: [PhotoSize]
    let text: String
}

class PhotoSize: BidirectionalMappable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
