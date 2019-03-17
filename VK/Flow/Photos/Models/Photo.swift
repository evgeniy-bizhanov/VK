//
//  Photo.swift
//  VK
//
//  Created by Евгений Бижанов on 17/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct VMPhoto: BidirectionalMappable {
    let id: Int
    let sizes: [PhotoSize]
    let text: String
}

struct VMPhotoSize: BidirectionalMappable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
