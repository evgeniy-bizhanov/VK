//
//  NewsfeedViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol NewsfeedOutput: class {}

class NewsfeedViewController: UIViewController {
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: NewsfeedInput?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input?.didLoad()
    }
    
    
    // MARK: - Initializers
}

extension NewsfeedViewController: NewsfeedOutput {}
