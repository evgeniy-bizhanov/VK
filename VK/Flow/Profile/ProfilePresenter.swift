//
//  ProfilePresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

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
        
        if let userId = userId {
            requestManager?.get(forUser: userId) { response in
                print(response.value?.response.items)
            }
        }
    }
    
    
    // MARK: - Initializers
    
    init(output: ProfileOutput?, requestManager: NetworkingService?, keychainStorage: KeyValueStorage?) {
        self.output = output
        self.requestManager = requestManager
        self.keychainStorage = keychainStorage
    }
}
