//
//  AppBuilder.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class AppBuilder: AbstractModuleBuilder {
    
    weak var proxy: AppDelegateProxy?
    
    override func resolve(resolver: Resolver) {
        proxy?.appDelegate = resolver.resolve(AppDelegate.self)
    }
    
    init(proxy: AppDelegateProxy?) {
        super.init()
        
        self.proxy = proxy
        awakeFromNib()
    }
}
