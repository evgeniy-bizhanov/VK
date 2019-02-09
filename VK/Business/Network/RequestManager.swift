//
//  RequestManager.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 24/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

// FIXME: - Remove after creating each view
typealias NetworkingService = FriendsRequestManager

class RequestManager: AbstractRequestManager {
    
    // MARK: - Properties
    
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let keychainStorage: KeyValueStorage?

    let url: URL! = URL(string: AppConfig.Api.url)
    lazy var token: String? = { keychainStorage?.string(forKey: "token") }()

    
    // MARK: - Functions
    
    // MARK: - Initializers
    
    required init(
        sessionManager: SessionManager,
        queue: DispatchQueue?,
        keychainStorage: KeyValueStorage?) {
        
        self.sessionManager = sessionManager
        self.queue = queue
        self.keychainStorage = keychainStorage
    }
    
    
}
