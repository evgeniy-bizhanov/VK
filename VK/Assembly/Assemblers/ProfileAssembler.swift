//
//  ProfileAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class ProfileAssembler: Assembly {
    func assemble(container: Container) {
//        container.register(FriendsRequestManager.self) { r in
//            return RequestFactoryHelper.makeFactory(RequestManager.self, resolver: r)
//        }
        
        container.register(ProfileInput.self) { r, output in
            return ProfilePresenter(
                output: output,
                requestManager: r.resolve(NetworkingService.self),
                keychainStorage: r.resolve(KeyValueStorage.self))
        }
    }
}
