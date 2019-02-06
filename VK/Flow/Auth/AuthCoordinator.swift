//
//  AuthCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

final class AuthCoordinator: AbstractCoordinator {
    
    override func start() {
        guard
            let controller = UIStoryboard(name: "Auth", bundle: nil)
                .instantiateInitialViewController() as? AuthViewController else {
            fatalError("Can't instantiate view controller with identifier \(AuthViewController.identifier)")
        }
        
        controller.finishFlow = onFinishFlow
        
        setAsRoot(controller)
    }
}
