//
//  NewsfeedPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol NewsfeedInput {
    func didLoad()
}

class NewsfeedPresenter: NSObject, NewsfeedInput {
    
    // MARK: - Models
    // MARK: - Services
    
    var requestManager: NewsfeedRequestable?
    
    
    // MARK: - Properties
    // MARK: - Fields
    
    private unowned var output: NewsfeedOutput
    private var newsfeed: VMNewsfeed?
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    
    // MARK: - Functions
    
    func didLoad() {
        
        requestManager?.get(withFilters: "post,photo") { [weak self](newsfeed: VMNewsfeed) in
            guard let self = self else {
                return
            }
            
            self.newsfeed = newsfeed
            
            DispatchQueue.main.async {
                self.output.reloadView()
            }
        }

    }
    
    
    // MARK: - Initializers
    
    init(output: NewsfeedOutput, requestManager: NewsfeedRequestable?) {
        self.output = output
        self.requestManager = requestManager
    }
}

extension NewsfeedPresenter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsfeed?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = newsfeed?.items[indexPath.section] else {
            return UITableViewCell()
        }
        
        let postedDate = Date(timeIntervalSince1970: TimeInterval(exactly: item.date)!)
        
        let headerModel: HeaderCellModel
        
        if item.sourceIsUser {
            let user: VMPerson! = newsfeed?.profiles?.first { $0.id == item.sourceId }
            headerModel = HeaderCellModel(
                postedImage: user.image,
                postedName: user.firstName,
                postedDate: dateFormatter.string(from: postedDate)
            )
        } else {
            let community: VMCommunity! = newsfeed?.groups?.first { $0.id == -item.sourceId }
            headerModel = HeaderCellModel(
                postedImage: community.photoLow,
                postedName: community.name,
                postedDate: dateFormatter.string(from: postedDate)
            )
        }
        
        
        return tableView.dequeueReusableCell(for: indexPath) { (cell: HeaderCell?) in
            cell?.model = headerModel
        }
    }
}
