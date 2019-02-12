//
//  FriendsCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class FriendsCoordinator: AbstractCoordinator {
    
    override func start() {
        guard
            let controller = UIStoryboard(name: "Friends", bundle: nil)
                .instantiateInitialViewController() as? FriendsViewController else {
                    fatalError("Can't instantiate view controller with identifier \(FriendsViewController.identifier)")
        }
        
        setAsRoot(controller)
    }
}
