//
//  NewsfeedRequestable.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

// MARK: - Protocol

protocol NewsfeedRequestable {
    
    typealias Newsfeed = Response<NewsfeedItem>
    typealias Completion<T: Decodable> = (T) -> Void
    
    /// Gets specified numbers of newsfeed items
    ///
    /// - Parameter startFrom: The identifier required to get the next page of results.
    /// The value required to pass in this parameter is returned in the `next_from` response field.
    ///
    /// - Parameter count: Indicates what maximum number of newsfeed items should be returned, but not more than 100.
    /// The default is 50.
    ///
    /// - Parameter filters: Comma-delimited names of newsfeed items to get
    ///
    /// - Parameter maxPhotos: The maximum number of photographs that must be returned.
    /// Default: 5, maximum value: 100.
    func get<T>(
        from startFrom: String?, count: Int,
        withFilters filters: String,
        maxPhotos: Int,
        completion: Completion<T>?)
}

extension NewsfeedRequestable {
    func get<T>(
        from startFrom: String? = nil, count: Int = 50,
        withFilters filters: String = "post,photo",
        maxPhotos: Int = 5,
        completion: Completion<T>?) {
        
        get(from: startFrom, count: count, withFilters: filters, maxPhotos: maxPhotos, completion: completion)
    }
}


// MARK: - Implementation

final class NewsfeedRequestManager: NewsfeedRequestable {
    
    var requestManager: AbstractRequestManager!
    
    func get<T>(
        from startFrom: String?, count: Int,
        withFilters filters: String,
        maxPhotos: Int,
        completion: Completion<T>?) {
        
        let urlRequest = GetRequestRouter(
            url: requestManager.url,
            startFrom: startFrom,
            count: count,
            filters: filters,
            maxPhotos: maxPhotos,
            token: requestManager.token ?? ""
        )
        
        requestManager.request(request: urlRequest) { (data: Newsfeed) in
            
            guard let data = try? data.response.mapDto(to: T.self) else {
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
    let apiMethod: String = "/newsfeed.get"
    
    let startFrom: String?
    let count: Int?
    let filters: String?
    let maxPhotos: Int?
    let token: String
    
    var parameters: Parameters? {
        
        var dict: Parameters = [
            "v": AppConfig.Api.version,
            "access_token": token
        ]
        
        if let startFrom = startFrom { dict["start_from"] = startFrom }
        if let count = count { dict["count"] = count }
        if let filters = filters { dict["filters"] = filters }
        if let maxPhotos = maxPhotos { dict["max_photos"] = maxPhotos }
        
        return dict
    }
}
