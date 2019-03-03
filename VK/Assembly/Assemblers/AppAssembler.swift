//
//  AppAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject
import KeychainAccess
import RealmSwift

class AppAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(KeyValueStorage.self) { _ in return Keychain() }
        
        container.register(Realm.Configuration.self) { _ in
            
            var configuration = Realm.Configuration.defaultConfiguration
            configuration.deleteRealmIfMigrationNeeded = true
            
            print(configuration.fileURL ?? "")
            
            return configuration
        }
        
        container.register(StorageContext.self) { r in
            return RealmStorageContext(db: try! Realm(configuration: r.resolve(Realm.Configuration.self)!))
        }
        
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
        
        container.register(DispatchQueue.self) { _ in
            DispatchQueue.global(qos: .userInteractive)
        }
    }
}
