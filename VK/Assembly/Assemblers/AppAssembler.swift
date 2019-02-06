//
//  AppAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject
import KeychainAccess

class AppAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(KeyValueStorage.self) { _ in return Keychain() }
        
        container.register(UIWindow.self) { _ in return UIWindow() }
        
        container.register(AbstractCoordinator.self) { r in
            return AppCoordinator(storage: r.resolve(KeyValueStorage.self))
        }
        
        container.register(AppDelegate.self) { r in
            return AppDelegate(
                window: r.resolve(UIWindow.self),
                coordinator: r.resolve(AbstractCoordinator.self)
            )
        }
    }
}
