//
//  PhotosAssembler.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Swinject

class PhotosAssembler: Assembly {
    
    func assemble(container: Container) {
        container.register(PhotosRequestable.self) { r in
            return PhotosRequestManager(requestManager: r.resolve(AbstractRequestManager.self))
        }
    }
}
