//
//  HeaderCell.swift
//  VK
//
//  Created by Евгений Бижанов on 17/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Kingfisher
import UIKit

class HeaderCell: UITableViewCell, Identifiable, NonseparatableCell {
    
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var postedName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    
    var model: HeaderCellModel? {
        willSet {
            setupCell(model: newValue)
        }
    }
    
    func setupCell(model: HeaderCellModel?) {
        
        guard let model = model else {
            return
        }
        
        if let url = URL(string: model.postedImage) {
            postedImage.kf.setImage(with: url)
        }
        
        postedName.text = model.postedName
        postedDate.text = model.postedDate
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

struct HeaderCellModel {
    let postedImage: String
    let postedName: String
    let postedDate: String
}
