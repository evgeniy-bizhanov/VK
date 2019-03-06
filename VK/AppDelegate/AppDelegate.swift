//
//  AppDelegate.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    var coordinator: AbstractCoordinator?
    
    
    // MARK: - Fields
    // MARK: - Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        window?.makeKeyAndVisible()
        coordinator?.start()
        
        return true
    }
    
    
    // MARK: - Initializers
    
    init(window: UIWindow?, coordinator: AbstractCoordinator?) {
        
        self.window = window
        self.coordinator = coordinator
    }
}
