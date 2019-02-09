//
//  GroupsRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol GroupsRequestManager: AbstractRequestManager {
    
    typealias Groups = Response<Group>
    
    /// Gets list of groups
    ///
    /// - Parameter userId: User identifier
    func get(forUser userId: String, completion: @escaping Completion<Groups>)
    
    /// Gets specified numbers of groups
    ///
    /// - Parameter userId: User identifier
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func get(
        forUser userId: String,
        count: Int,
        offset: Int,
        completion: @escaping Completion<Groups>
    )
}

extension RequestManager: GroupsRequestManager {
    
    func get(forUser userId: String, completion: @escaping Completion<Groups>) {
        get(forUser: userId, count: 50, offset: 0, completion: completion)
    }
    
    func get(
        forUser userId: String,
        count: Int,
        offset: Int,
        completion: @escaping Completion<Groups>) {
        
        let urlRequest = GetRequestRouter(url: url, userId: userId, count: count, offset: offset, token: token)
        self.request(request: urlRequest, completion: completion)
    }
}


// MARK: - RequestRouter

fileprivate struct GetRequestRouter: RequestRouter {
    
    let url: URL
    let httpMethod: HTTPMethod = .get
    let apiMethod: String = "/groups.get"
    
    let userId: String
    let extended = 1
    let count: Int
    let offset: Int
    let token: String?
    
    var parameters: Parameters? {
        return [
            "user_id": userId,
            "extended": extended,
            "offset": offset,
            "count": count,
            "v": AppConfig.Api.version,
            "access_token": token ?? ""
        ]
    }
}
