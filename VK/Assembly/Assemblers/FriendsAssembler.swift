//
//  FriendsAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class FriendsAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(FriendsRequestable.self) { r in
            return FriendsRequestManager(requestManager: r.resolve(AbstractRequestManager.self))
        }
        
        container.register(FriendsViewInput.self) { r, output in
            return FriendsPresenter(
                output: output,
                requestManager: r.resolve(FriendsRequestable.self),
                storageManager: r.resolve(KeyValueStorage.self),
                context: r.resolve(StorageContext.self))
        }
    }
}
