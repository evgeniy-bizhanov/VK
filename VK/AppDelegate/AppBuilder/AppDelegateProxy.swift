//
//  AppDelegateProxy.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegateProxy: UIResponder, UIApplicationDelegate {
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var appDelegate: UIApplicationDelegate!
    
    
    // MARK: - Fields
    
    private var builder: AbstractModuleBuilder?
    
    
    // MARK: - Functions
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return appDelegate?.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? false
    }
    
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        builder = AppBuilder(proxy: self)
    }
}
