//
//  AuthPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol AuthInput {
    func didLoad()
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
        ///
    }
    
    
    // MARK: - Initializers
    
    init(output: AuthOutput?, storage: KeyValueStorage?) {
        self.output = output
        self.storage = storage
    }
}
