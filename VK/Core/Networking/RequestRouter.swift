//
//  RequestRouter.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Alamofire

enum RequestRouterEncoding {
    case url, json
}

protocol RequestRouter: URLRequestConvertible {
    
    var url: URL { get }
    var httpMethod: HTTPMethod { get }
    var encoding: RequestRouterEncoding { get }
    var apiMethod: String { get }
    var token: String? { get }
    
    var parameters: Parameters? { get }
}

extension RequestRouter {
    
    var encoding: RequestRouterEncoding {
        
        switch httpMethod {
        case .get:
            return .url
        default:
            return .json
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Invalid url")
        }
        
        urlComponents.path += apiMethod
        
        var urlRequest = URLRequest(url: try urlComponents.asURL())
        urlRequest.httpMethod = httpMethod.rawValue
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
