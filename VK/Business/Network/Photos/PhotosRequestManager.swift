//
//  PhotosRequestManager.swift
//  VK
//
//  Created by Евгений Бижанов on 09/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol PhotosRequestManager: AbstractRequestManager {
    func test()
}

extension RequestManager: PhotosRequestManager {
    func test() {}
}
