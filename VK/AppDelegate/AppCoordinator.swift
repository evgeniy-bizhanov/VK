//
//  AppCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Foundation

final class AppCoordinator: AbstractCoordinator {
    
    var storage: KeyValueStorage?
    
    override func start() {
        if let token = storage?.string(forKey: "token") {
            Singleton.shared.token = token
            navigateTo(ProfileCoordinator.self, parameters: ["token": token])
        } else {
            navigateTo(AuthCoordinator.self)
        }
    }
    
    convenience init(storage: KeyValueStorage?) {
        self.init()
        self.storage = storage
    }
}
