//
//  FriendsPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol FriendsViewInput {
    func didLoad()
}

class FriendsPresenter: NSObject, FriendsViewInput {
    
    // MARK: - Models
    
    var items: [PersonViewItem]?
    
    
    // MARK: - Services
    
    var requestManager: FriendsRequestable?
    let storageManager: KeyValueStorage?
    
    
    // MARK: - Properties
    
    unowned var output: FriendsViewOutput
    
    
    // MARK: - Fields
    
    private lazy var userId: String? = { return storageManager?.string(forKey: "userId") }()
    var contentLetters: [String]?
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    func didLoad() {
        
        guard let userId = userId else {
            fatalError("User id can't be null")
        }
        
        requestManager?.get(forUser: userId) { [weak self](response: [VMPerson]) in
            
            guard let self = self else {
                return
            }
            
            let sorted = response.sorted { first, second in
                first.lastName < second.lastName
            }
            
            let dictionary = Dictionary(grouping: sorted, by: { String($0.lastName.first ?? $0.firstName.first ?? "#") }).sorted { (first, second) in
                first.key < second.key
            }
            
            let onlinePersons = PersonViewItem(.online, withValues: sorted.filter { $0.isOnline })
            
            self.items = [onlinePersons].compactMap { $0 }
            
            dictionary.forEach { key, value in
                if let item = PersonViewItem(.offline, label: key, withValues: value) {
                    self.items?.append(item)
                }
            }
            
            self.contentLetters = dictionary.map { key, _ in
                return key
            }
            
            DispatchQueue.main.async {
                self.output.fetchedData()
            }
        }
        
    }
    
    
    // MARK: - Initializers
    
    init(output: FriendsViewOutput, requestManager: FriendsRequestable?, storageManager: KeyValueStorage?) {
        self.output = output
        self.requestManager = requestManager
        self.storageManager = storageManager
    }
}

extension FriendsPresenter: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contentLetters
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableView.numberOfSections > 1 ? items?[section].label ?? items?[section].type.label : nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?[section].rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = items?[indexPath.section] else {
            return UITableViewCell()
        }
        
        let identifier = item.type.identifier
        
        return tableView
            .dequeueReusableCell(withIdentifier: identifier, for: indexPath) { (cell: PersonViewCell?) in
                guard let cell = cell else {
                    return
                }
                
                cell.model = item.collection[indexPath.row]
        }
    }
}
