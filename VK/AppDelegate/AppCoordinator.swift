//
//  AppCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Foundation

final class AppCoordinator: AbstractCoordinator {
    
    override func start() {
        if let token = UserDefaults.standard.value(forKey: "token") as? String {
            navigateTo(MainCoordinator.self, parameters: ["token": token])
        } else {
            navigateTo(AuthCoordinator.self)
        }
        
    }
}
