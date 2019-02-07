//
//  Session.swift
//  VK
//
//  Created by Евгений Бижанов on 06/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

class Session {
    var token: String?
    var userId: UInt?
    
    static let shared = Session()
    private init() {}
}
