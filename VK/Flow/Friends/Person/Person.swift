//
//  Friend.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Foundation
import UIKit

final class VMPerson: Decodable, CustomStringConvertible {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var image: String = ""
    var isOnline: Bool = false
    
    var description: String {
        return lastName
    }
}
