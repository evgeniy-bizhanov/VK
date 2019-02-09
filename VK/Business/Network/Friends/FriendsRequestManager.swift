//
//  FriendsRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

// MARK: - Protocol

protocol FriendsRequestManager: AbstractRequestManager {
    
    typealias Friends = Response<Friend>
    
    /// Gets list of friends
    ///
    /// - Parameter userId: User identifier
    func get(forUser userId: String, completion: @escaping Completion<Friends>)
    
    /// Gets list of friends
    ///
    /// - Parameter userId: User identifier
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func get(forUser userId: String, count: Int, offset: Int, completion: @escaping Completion<Friends>)
}


// MARK: - Implementation

extension RequestManager: FriendsRequestManager {
    func get(forUser userId: String, completion: @escaping Completion<Friends>) {
        get(forUser: userId, count: 50, offset: 0, completion: completion)
    }
    
    func get(forUser userId: String, count: Int, offset: Int, completion: @escaping Completion<Friends>) {
        
        let urlRequest = GetRequestRouter(
            url: url,
            userId: userId,
            count: count,
            offset: offset,
            fields: "online",
            token: token
        )
        
        self.request(request: urlRequest, completion: completion)
    }
}


// MARK: - RequestRouter

fileprivate struct GetRequestRouter: RequestRouter {
    
    let url: URL
    let httpMethod: HTTPMethod = .get
    let apiMethod: String = "/friends.get"
    
    let userId: String
    let count: Int
    let offset: Int
    let fields: String
    let token: String?
    
    var parameters: Parameters? {
        return [
            "user_id": userId,
            "count": count,
            "offset": offset,
            "fields": fields,
            "v": AppConfig.Api.version,
            "access_token": token ?? ""
        ]
    }
}
