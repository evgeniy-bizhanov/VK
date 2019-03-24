//
//  Operators.swift
//  VK
//
//  Created by Евгений Бижанов on 24/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

infix operator />
func />(lhs: AnyObject, rhs: (AnyObject) -> Void) -> AnyObject {
    rhs(lhs)
    return lhs
}
