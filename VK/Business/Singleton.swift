//
//  Singleton.swift
//  VK
//
//  Created by Евгений Бижанов on 06/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

class Singleton {
    var token: String?
    
    static let shared = Singleton()
    private init() {}
}
