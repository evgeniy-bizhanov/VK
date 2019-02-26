//
//  GroupsRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol CommunitiesRequestable {
    
    typealias Groups = Response<Community>
    typealias Completion<T: Decodable> = (T) -> Void
    
    /// Gets list of communities
    ///
    /// - Parameter userId: User identifier
    func get<T>(forUser userId: String, completion: Completion<T>?)
    
    /// Gets specified numbers of communities
    ///
    /// - Parameter userId: User identifier
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func get<T>(
        forUser userId: String,
        count: Int,
        offset: Int,
        completion: Completion<T>?
    )
    
    /// Searches communities for a given substring
    ///
    /// - Parameter query: Query substring
    func search<T>(byQuery query: String, completion: Completion<T>?)
    
    /// Searches specified numbers of communities for a given substring
    ///
    /// - Parameter query: Query substring
    /// - Parameter count: Number of entries returned
    /// - Parameter offset: Return entries offset
    func search<T>(
        byQuery query: String,
        count: Int,
        offset: Int,
        completion: Completion<T>?
    )
}

final class CommunitiesRequestManager: CommunitiesRequestable {
    
    var requestManager: AbstractRequestManager!
    
    // MARK: Getting
    func get<T>(forUser userId: String, completion: Completion<T>?) {
        get(forUser: userId, count: 50, offset: 0, completion: completion)
    }
    
    func get<T>(
        forUser userId: String,
        count: Int,
        offset: Int,
        completion: Completion<T>?) {
        
        let urlRequest = GetRequestRouter(
            url: requestManager.url,
            userId: userId,
            count: count,
            offset: offset,
            token: requestManager.token ?? ""
        )
        
        requestManager.request(request: urlRequest, completion: completion)
    }
    
    
    // MARK: Searching
    
    func search<T>(byQuery query: String, completion: Completion<T>?) {
        search(byQuery: query, count: 50, offset: 0, completion: completion)
    }
    
    func search<T>(
        byQuery query: String,
        count: Int,
        offset: Int,
        completion: Completion<T>?) {
        
        let urlRequest = SearchRequestRouter(
            url: requestManager.url,
            query: query,
            count: count,
            offset: offset,
            token: requestManager.token ?? ""
        )
        
        requestManager.request(request: urlRequest, completion: completion)
    }
    
    init(requestManager: AbstractRequestManager?) {
        self.requestManager = requestManager
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
    let token: String
    
    var parameters: Parameters? {
        return [
            "user_id": userId,
            "extended": extended,
            "offset": offset,
            "count": count,
            "v": AppConfig.Api.version,
            "access_token": token
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
    let token: String
    
    var parameters: Parameters? {
        return [
            "q": query,
            "offset": offset,
            "count": count,
            "v": AppConfig.Api.version,
            "access_token": token
        ]
    }
}
