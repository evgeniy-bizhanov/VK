//
//  FriendsRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

extension RequestManager: FriendsRequest {
    func get(forUser userId: String, count: Int, offset: Int, completion: @escaping Completion<[Friend]>) {
        
        let urlRequest = GetRouter(
            url: url,
            userId: userId,
            count: count,
            offset: offset,
            fields: "online"
        )
        
        self.request(request: urlRequest, completion: completion)
    }
}

fileprivate struct GetRouter: RequestRouter {
    
    let url: URL
    let httpMethod: HTTPMethod = .get
    let apiMethod: String = "/friends.get"
    
    let userId: String
    let count: Int
    let offset: Int
    let fields: String
    
    var parameters: Parameters? {
        return [
            "user_id": userId,
            "count": count,
            "offset": offset,
            "fields": fields
        ]
    }
}
