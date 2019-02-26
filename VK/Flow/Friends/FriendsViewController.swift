//
//  FriendsViewController.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol FriendsViewOutput: class {
    func fetchedData()
}

class FriendsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: FriendsViewInput?
    
    
    // MARK: - Fields
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = input as? UITableViewDataSource
        input?.didLoad()
        setupSearchController()
    }
    
    func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Поиск..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK: - Initializers
}

extension FriendsViewController: FriendsViewOutput {
    func fetchedData() {
        tableView.reloadData()
    }
}
