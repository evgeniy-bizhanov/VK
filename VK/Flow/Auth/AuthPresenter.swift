//
//  AuthPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Foundation

protocol AuthInput {
    func didLoad()
    func retrieveToken(fromUrl url: URL) -> Result<String>
    func retrieved(token: String)
}

class AuthPresenter: AuthInput {
    
    // MARK: - Models
    // MARK: - Services
    
    var storage: KeyValueStorage?
    
    
    // MARK: - Properties
    
    var output: AuthOutput?
    
    
    // MARK: - Fields
    // MARK: - Functions
    
    func didLoad() {
        if let request = AppConfig.Authentication.asURLRequest() {
            output?.reload(withUrlRequest: request)
        }
    }
    
    func retrieveToken(fromUrl url: URL) -> Result<String> {
        guard
            let fragment = url.fragment,
            fragment.range(of: "access_token") != nil,
            let token = fragment.components(separatedBy: "access_token=").last else {
                return .error("В переданном url токен не найден")
        }
        
        return .success(token)
    }
    
    func retrieved(token: String) {
        storage?.set(value: token, forKey: "token")
    }
    
    
    // MARK: - Initializers
    
    init(output: AuthOutput?, storage: KeyValueStorage?) {
        self.output = output
        self.storage = storage
    }
}

fileprivate extension AppConfig.Authentication {
    
    static func asURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: AppConfig.Authentication.url) else {
            return nil
        }
        
        components.queryItems = [
            URLQueryItem(name: "client_id", value: AppConfig.Authentication.id),
            URLQueryItem(name: "redirect_uri", value: ""),
            URLQueryItem(name: "scope", value: "friends"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: AppConfig.Api.version),
            URLQueryItem(name: "display", value: "mobile")
        ]
        
        if let url = components.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
}
