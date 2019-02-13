//
//  OfflineView.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class OfflineView: UITableViewCell, PersonViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var title: UILabel!
    
    
    // MARK: - Models
    
    var model: VMPerson? {
        didSet {
            title.text = model?.firstName
        }
    }
    
    
    // MARK: - Services
    // MARK: - Properties
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Initializers
}
