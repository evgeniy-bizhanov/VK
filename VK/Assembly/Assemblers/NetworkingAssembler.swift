//
//  NetworkingAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 08/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject
import Alamofire

class NetworkingAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SessionManager.self) { _ in
            return makeSessionManager()
        }.inObjectScope(.container)
    }
}

/// Создает и конфигурирует менеджер сессий
fileprivate func makeSessionManager() -> SessionManager {
    let configuration = URLSessionConfiguration.default
    configuration.httpShouldSetCookies = false
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    
    let manager = SessionManager(configuration: configuration)
    return manager
}
