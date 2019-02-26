//
//  FriendsModuleBuilder.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class FriendsModuleBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var viewController: FriendsViewController!
    
    override func resolve(resolver: Resolver) {
        viewController.input = resolver.resolve(FriendsViewInput.self, argument: viewController as FriendsViewOutput)
    }
}
