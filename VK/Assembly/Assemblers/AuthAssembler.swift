//
//  AuthAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject
import KeychainAccess

class AuthAssembler: Assembly {
    func assemble(container: Container) {
        container.register(AuthInput.self) { r, output in
            return AuthPresenter(output: output, storage: r.resolve(KeyValueStorage.self))
        }
    }
}
