//
//  CommunitiesAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class CommunitiesAssembler: Assembly {
    
    func assemble(container: Container) {
        container.register(CommunitiesRequestable.self) { r in
            return CommunitiesRequestManager(requestManager: r.resolve(AbstractRequestManager.self))
        }
    }
}
