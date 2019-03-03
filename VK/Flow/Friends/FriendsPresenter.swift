//
//  FriendsPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 12/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit
import RealmSwift

protocol FriendsViewInput {
    func didLoad()
}

class FriendsPresenter: NSObject, FriendsViewInput {
    
    // MARK: - Models
    
    var items: [PersonViewItem]?
    
    
    // MARK: - Services
    
    var requestManager: FriendsRequestable?
    let storageManager: KeyValueStorage?
    let context: StorageContext?
    
    
    // MARK: - Properties
    
    unowned var output: FriendsViewOutput
    
    
    // MARK: - Fields
    
    private lazy var userId: String? = { return storageManager?.string(forKey: "userId") }()
    var contentLetters: [String]?
    private var token: NotificationToken?
    private var query: Results<RMPerson>?
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    func didLoad() {
        
        guard let userId = userId else {
            fatalError("User id can't be null")
        }
        
        if let realmPersons = context?.fetch(RMPerson.self).nonEmpty {
            observe(realmPersons)
            query = realmPersons
        } else {
            friends(forUser: userId)
        }
    }
    
    private func observe(_ realmPersons: Results<RMPerson>) {
        token = realmPersons.observe { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .error(let error):
                print(error)
            case .initial(let collection):
                print(collection)
                self.translate(items: collection)
                self.didLoadItems()
            case .update(_, let deletions, let insertions, let modifications):
                // Do some stuff
                break
            }
        }
    }
    
    private func friends(forUser userId: String) {
        requestManager?.get(forUser: userId) { [weak self] (response: [RMPerson]) in
            
            guard let self = self else { return }
            try? self.context?.save(response)
            self.didLoad()
        }
    }
    
    func translate(items: Results<RMPerson>) {
        let sorted = items.sorted { first, second in
            first.lastName < second.lastName
        }
        
        let dictionary = Dictionary(grouping: sorted, by: { $0.label }).sorted { (first, second) in
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
    }
    
    func didLoadItems() {
        DispatchQueue.main.async {
            self.output.fetchedData()
        }
    }
    
    
    // MARK: - Initializers
    
    init(
        output: FriendsViewOutput,
        requestManager: FriendsRequestable?,
        storageManager: KeyValueStorage?,
        context: StorageContext?) {
        
        self.output = output
        self.requestManager = requestManager
        self.storageManager = storageManager
        self.context = context
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
                
                cell.model = try? item.collection[indexPath.row].mapDto(to: VMPerson.self)
        }
    }
}
