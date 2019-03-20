//
//  PostCell.swift
//  VK
//
//  Created by Евгений Бижанов on 19/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell, Identifiable {

    @IBOutlet weak var postedTextLabel: UILabel!
    
    var model: PostCellModel? {
        willSet {
            setupCell(model: newValue)
        }
    }
    
    func setupCell(model: PostCellModel?) {
        
        guard let model = model else {
            return
        }
        
        postedTextLabel.text = model.text
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

struct PostCellModel {
    let text: String?
}
