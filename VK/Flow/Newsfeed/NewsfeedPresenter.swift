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
        
        requestManager?.get(withFilters: "photo") { [weak self](newsfeed: VMNewsfeed) in
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
        guard let section = newsfeed?.items[section] else { return 0 }
        return section.type == "post" ? 3 : 2
    }
    
    fileprivate func headerCell(
        forNewsfeedItem item: VMNewsfeedItem,
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    fileprivate func footerCell(
        forNewsfeedItem item: VMNewsfeedItem,
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let likes = item.likes,
            let reposts = item.reposts else {
                return UITableViewCell()
        }
        
        return tableView.dequeueReusableCell(for: indexPath) { (cell: FooterCell?) in
            cell?.counterDelegate = { count in
                if count > 999 {
                    return String(format: "%.1fK", Float(count) / 1000)
                } else if count > 999999 {
                    return String(format: "%.1fM", Float(count) / 1000000)
                } else if count > 999999999 {
                    return String(format: "%.1fB", Double(count) / 1000000000)
                }
                return String(count)
            }
            cell?.model = FooterCellModel(likes: likes, reposts: reposts)
        }
    }
    
    fileprivate func contentCell(
        forNewsfeedItem item: VMNewsfeedItem,
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch item.type {
        case "post":
            return postCell(forNewsfeedItem: item, tableView, cellForRowAt: indexPath)
        case "photo":
            return photoCell(forNewsfeedItem: item, tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func postCell(
        forNewsfeedItem item: VMNewsfeedItem,
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = PostCellModel(text: item.text)
        
        return tableView.dequeueReusableCell(for: indexPath) { (cell: PostCell?) in
            cell?.model = model
        }
    }
    
    fileprivate func photoCell(
        forNewsfeedItem item: VMNewsfeedItem,
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(for: indexPath) { (cell: PhotoCell?) in
            //
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = newsfeed?.items[indexPath.section] else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            return headerCell(forNewsfeedItem: item, tableView, cellForRowAt: indexPath)
        case 1:
            return contentCell(forNewsfeedItem: item, tableView, cellForRowAt: indexPath)
        case 2:
            return footerCell(forNewsfeedItem: item, tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
}
