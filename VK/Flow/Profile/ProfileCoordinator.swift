//
//  ProfileCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

final class ProfileCoordinator: AbstractCoordinator {
    
    var navigation: UINavigationController?
    
    override func start() {
        guard
            let controller = UIStoryboard(name: "Profile", bundle: nil)
                .instantiateInitialViewController() as? ProfileViewController else {
                    fatalError("Can't instantiate view controller with identifier \(ProfileViewController.identifier)")
        }
        
        setAsRoot(controller)
    }
}
