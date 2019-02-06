//
//  AuthModuleBuilder.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class AuthModuleBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var viewController: AuthViewController!
    
    override func resolve(resolver: Resolver) {
        viewController.input = resolver.resolve(AuthInput.self, argument: viewController as AuthOutput?)
    }
}
