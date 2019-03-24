//
//  SeparatableCell.swift
//  VK
//
//  Created by Евгений Бижанов on 24/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

public protocol SeparatableCell {
    func setupSeparator(with separator: UIEdgeInsets) 
}

extension SeparatableCell where Self: UITableViewCell {
    public func setupSeparator(with separator: UIEdgeInsets = .zero) {
        separatorInset = separator
    }
}

public protocol NonseparatableCell {
    func removeSeparator()
}

extension NonseparatableCell where Self: UITableViewCell {
    public func removeSeparator() {
        separatorInset.left = frame.maxX
    }
}
