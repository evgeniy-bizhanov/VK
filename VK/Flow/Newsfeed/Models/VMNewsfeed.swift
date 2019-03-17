//
//  VMNewsfeed.swift
//  VK
//
//  Created by Евгений Бижанов on 17/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

class VMNewsfeed: Decodable {
    let items: [VMNewsfeedItem]
    let profiles: [VMPerson]?
    let groups: [VMCommunity]?
    let newOffset: String?
    let nextFrom: String?
}

class VMNewsfeedItem: Decodable {
    let type: String
    let sourceId: Int
    let date: Int
    let text: String?
    let comments: VMComments?
    let likes: VMLikes?
    let reposts: VMReposts?
    let photos: VMPhotos?
}
