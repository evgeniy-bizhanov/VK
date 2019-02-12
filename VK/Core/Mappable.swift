//
//  Mappable.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 02/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

typealias BidirectionalMappable = Mappable & Decodable

/// Экземпляры протокола могут быть сконвертированы друг в друга
protocol Mappable: Encodable {
    /// Выполняет мэппинг свойств одного типа на другой
    func mapDto<T: Decodable>() throws -> T
}

extension Mappable {
    public func mapDto<T: Decodable>() throws -> T {
        let encoded = try PropertyListEncoder().encode(self)
        return try PropertyListDecoder().decode(T.self, from: encoded)
    }
}
