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
    
    /// Gets list of communities
    ///
    /// - Parameter userId: User identifier
    func get(forUser userId: String, completion: @escaping Completion<Groups>)
    
    /// Gets specified numbers of communities
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
    
    /// Searches communities for a given substring
    ///
    /// - Parameter query: Query substring
    func search(byQuery query: String, completion: @escaping Completion<Groups>)
    
    /// Searches specified numbers of communities for a given substring
    ///
    /// - Parameter query: Query substring
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func search(
        byQuery query: String,
        count: Int,
        offset: Int,
        completion: @escaping Completion<Groups>
    )
}

extension RequestManager: GroupsRequestManager {
    
    // MARK: Getting
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
    
    
    // MARK: Searching
    
    func search(byQuery query: String, completion: @escaping Completion<Groups>) {
        search(byQuery: query, count: 50, offset: 0, completion: completion)
    }
    
    func search(
        byQuery query: String,
        count: Int,
        offset: Int,
        completion: @escaping Completion<Groups>) {
        
        let urlRequest = SearchRequestRouter(
            url: url,
            query: query,
            count: count,
            offset: offset,
            token: token
        )
        
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

fileprivate struct SearchRequestRouter: RequestRouter {
    
    let url: URL
    let httpMethod: HTTPMethod = .get
    let apiMethod: String = "/groups.search"
    
    let query: String
    let count: Int
    let offset: Int
    let token: String?
    
    var parameters: Parameters? {
        return [
            "q": query,
            "offset": offset,
            "count": count,
            "v": AppConfig.Api.version,
            "access_token": token ?? ""
        ]
    }
}
