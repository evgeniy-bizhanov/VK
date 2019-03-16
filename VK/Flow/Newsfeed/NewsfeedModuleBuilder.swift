//
//  NewsfeedModuleBuilder.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class NewsfeedModuleBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var vc: NewsfeedViewController!
    
    override func resolve(resolver: Resolver) {
        vc.input = resolver.resolve(NewsfeedInput.self, argument: vc as NewsfeedOutput)
    }
}
