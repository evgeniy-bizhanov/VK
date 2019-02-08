//
//  FriendsRequest.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol FriendsRequest: AbstractRequestManager {
    func get(forUser userId: String, count: Int, offset: Int, completion: @escaping Completion<[Friend]>)
}
