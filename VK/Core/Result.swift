//
//  Result.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

enum Result<T>: Error {
    case error(_ error: String)
    case success(_ result: T)
}
