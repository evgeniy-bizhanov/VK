//
//  ProfilePresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Foundation

protocol ProfileInput {
    func didLoad()
}

class ProfilePresenter: ProfileInput {
    
    // MARK: - Models
    // MARK: - Services
    
    let requestManager: NetworkingService?
    let keychainStorage: KeyValueStorage?
    
    
    // MARK: - Properties
    
    var output: ProfileOutput?
    
    
    // MARK: - Fields
    
    private lazy var userId: String? = { return keychainStorage?.string(forKey: "userId") }()
    
    
    // MARK: - Functions
    
    func didLoad() {
        
        guard let userId = userId else {
            fatalError("User id can't be null")
        }
        
        (requestManager as? FriendsRequestManager)?.get(forUser: userId, count: 1, offset: 0) { response in
            print("\n-- FRIENDS --\n \(response.value?.response.items)")
        }
        
        requestManager?.get(forUser: userId, albumId: .profile, count: 1, offset: 0) { response in
            print("\n-- PHOTOS --\n \(response.value?.response.items)")
        }
        
        (requestManager as? GroupsRequestManager)?.get(forUser: userId, count: 1, offset: 0) { response in
            print("\n-- GROUPS --\n \(response.value?.response.items)")
        }
    }
    
    
    // MARK: - Initializers
    
    init(output: ProfileOutput?, requestManager: NetworkingService?, keychainStorage: KeyValueStorage?) {
        self.output = output
        self.requestManager = requestManager
        self.keychainStorage = keychainStorage
    }
}
