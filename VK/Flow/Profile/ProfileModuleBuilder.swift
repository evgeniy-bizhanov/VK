//
//  ProfileModuleBuilder.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class ProfileModuleBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var viewController: ProfileViewController!
    
    override func resolve(resolver: Resolver) {
        viewController.input = resolver.resolve(ProfileInput.self, argument: viewController as ProfileOutput?)
    }
}
