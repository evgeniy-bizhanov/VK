//
//  UIViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 04/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

// MARK: - Identifiable
extension UIViewController: Identifiable { }


// MARK: - Functions

extension UIViewController {
    
    func findChild<T>(_ : T.Type) -> T? {
        
        var founded: T?
        
        self.children.forEach { child in
            if child.children.count > 0 {
                founded = child.findChild(T.self)
            }
            
            if child is T {
                founded = child as? T
                return
            }
        }
        
        return founded
    }
}
