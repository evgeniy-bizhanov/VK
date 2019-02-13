//
//  MainCoordinator.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class MainCoordinator: AbstractCoordinator {
    
    override func start() {
        guard
            let controller = UIStoryboard(name: "Main", bundle: nil)
                .instantiateInitialViewController() else {
                    fatalError("Can't instantiate view controller")
        }
        
        setupFriendsTab(controller.findChild(FriendsViewController.self))
        setupCommunitiesTab(controller.findChild(CommunitiesViewController.self))
        setupPhotosTab(controller.findChild(PhotosViewController.self))
        
        setAsRoot(controller)
    }
    
    fileprivate func setupFriendsTab(_ tab: FriendsViewController?) {
        // Some code
    }
    
    fileprivate func setupCommunitiesTab(_ tab: CommunitiesViewController?) {
        // Some code
    }
    
    fileprivate func setupPhotosTab(_ tab: PhotosViewController?) {
        // Some code
    }
}
