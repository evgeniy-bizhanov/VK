//
//  RequestFactoryHelper.swift
//  VK
//
//  Created by Евгений Бижанов on 26/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire
import Swinject

class RequestFactoryHelper {
    /**
     Создает сервисы по их типам
     
     - Parameters:
     - service: Тип сервиса, которых необходимо создать
     - resolver: Контейнер разрешения зависимостей
     */
    static func makeFactory<T: AbstractRequestManager>(_ service: T.Type, resolver: Resolver) -> T {
        
        guard
            let sessionManager = resolver.resolve(SessionManager.self),
            let keychainStorage = resolver.resolve(KeyValueStorage.self),
            let sessionQueue = resolver.resolve(DispatchQueue.self) else {
                fatalError("Error parser and session manager resolved as nil for some reason")
        }
        
        return T(sessionManager: sessionManager, queue: sessionQueue, keychainStorage: keychainStorage)
    }
}
