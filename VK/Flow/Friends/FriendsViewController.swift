//
//  FriendsViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol FriendsViewOutput: class {}

class FriendsViewController: UIViewController {
    
    // MARK: - IBOutlets
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: FriendsViewInput?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input?.didLoad()
    }
    
    
    // MARK: - Initializers
}

extension FriendsViewController: FriendsViewOutput {}
