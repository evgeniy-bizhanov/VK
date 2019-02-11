//
//  ProfileViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 05/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol ProfileOutput {}

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var token: UILabel!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: ProfileInput?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input?.didLoad()
    }
    
    
    // MARK: - Initializers
}

extension ProfileViewController: ProfileOutput {}
