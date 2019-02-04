//
//  AppDelegate.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()

        coordinator = AppCoordinator()
        coordinator?.start()
        
        return true
    }


}

