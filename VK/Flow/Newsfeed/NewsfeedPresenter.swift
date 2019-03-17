//
//  NewsfeedPresenter.swift
//  VK
//
//  Created by Евгений Бижанов on 16/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol NewsfeedInput {
    func didLoad()
}

class NewsfeedPresenter: NewsfeedInput {
    
    // MARK: - Models
    // MARK: - Services
    
    var requestManager: NewsfeedRequestable?
    
    
    // MARK: - Properties
    // MARK: - Fields
    
    private unowned var output: NewsfeedOutput
    
    
    // MARK: - Functions
    
    func didLoad() {
        
        requestManager?.get(withFilters: "post,photo") { (newsfeed: VMNewsfeed) in
            print(newsfeed)
        }

    }
    
    
    // MARK: - Initializers
    
    init(output: NewsfeedOutput, requestManager: NewsfeedRequestable?) {
        self.output = output
        self.requestManager = requestManager
    }
}
