//
//  NewsfeedViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol NewsfeedOutput: class {
    func reloadView()
}

class NewsfeedViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var tableView: UITableView!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: NewsfeedInput?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = input as? UITableViewDataSource
        
        input?.didLoad()
    }
    
    
    // MARK: - Initializers
}

extension NewsfeedViewController: NewsfeedOutput {
    func reloadView() {
        tableView.reloadData()
    }
}
