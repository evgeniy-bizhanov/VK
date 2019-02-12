//
//  FriendsRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

// MARK: - Protocol

protocol FriendsRequestable {
    
    typealias Friends = Response<Friend>
    typealias Completion<T: Decodable> = (T) -> Void
    
    /// Gets list of friends
    ///
    /// - Parameter userId: User identifier
    func get<T>(forUser userId: String, completion: Completion<T>?)
    
    /// Gets specified numbers of friends
    ///
    /// - Parameter userId: User identifier
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func get<T>(forUser userId: String, count: Int, offset: Int, completion: Completion<T>?)
}


// MARK: - Implementation

final class FriendsRequestManager: FriendsRequestable {
    
    var requestManager: AbstractRequestManager!
    
    func get<T>(forUser userId: String, completion: Completion<T>?) {
        get(forUser: userId, count: 50, offset: 0, completion: completion)
    }
    
    func get<T>(forUser userId: String, count: Int, offset: Int, completion: Completion<T>?) {
        
        let urlRequest = GetRequestRouter(
            url: requestManager.url,
            userId: userId,
            count: count,
            offset: offset,
            fields: "online",
            token: requestManager.token ?? ""
        )
        
        requestManager.request(request: urlRequest) { (data: Friends) in
            
            guard let data = try? data.response.items.mapDto(to: T.self) else {
                preconditionFailure("Failure: Cant map \(T.self)")
            }
            
            completion?(data)
        }
    }
    
    init(requestManager: AbstractRequestManager?) {
        self.requestManager = requestManager
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
    let token: String
    
    var parameters: Parameters? {
        return [
            "user_id": userId,
            "count": count,
            "offset": offset,
            "fields": fields,
            "v": AppConfig.Api.version,
            "access_token": token
        ]
    }
}
