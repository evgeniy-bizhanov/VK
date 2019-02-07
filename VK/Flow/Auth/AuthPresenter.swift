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
    func retrieved(token: String?, forUser userId: String?)
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
    
    func retrieved(token: String?, forUser userId: String?) {
        guard let token = token, let userId = userId else {
            fatalError("Token or user id is nil")
        }
        
        storage?.set(value: token, forKey: "token")
        storage?.set(value: userId, forKey: "userId")
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
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, messages, wall, groups, notifications"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "state", value: "success"),
            URLQueryItem(name: "v", value: AppConfig.Api.version)
        ]
        
        if let url = components.url {
            return URLRequest(url: url)
        }
        
        return nil
    }
}
