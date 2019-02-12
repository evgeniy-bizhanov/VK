//
//  FriendsPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol FriendsViewInput {
    func didLoad()
}

class FriendsPresenter: FriendsViewInput {
    
    // MARK: - Models
    // MARK: - Services
    
    var requestManager: FriendsRequestable?
    let storageManager: KeyValueStorage?
    
    
    // MARK: - Properties
    
    unowned var output: FriendsViewOutput
    
    
    // MARK: - Fields
    
    private lazy var userId: String? = { return storageManager?.string(forKey: "userId") }()
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    func didLoad() {
        
        guard let userId = userId else {
            fatalError("User id can't be null")
        }
        
        requestManager?.get(forUser: userId, count: 1, offset: 0) { (response: [VMFriend]) in
            print(response)
        }
        
    }
    
    
    // MARK: - Initializers
    
    init(output: FriendsViewOutput, requestManager: FriendsRequestable?, storageManager: KeyValueStorage?) {
        self.output = output
        self.requestManager = requestManager
        self.storageManager = storageManager
    }
}
