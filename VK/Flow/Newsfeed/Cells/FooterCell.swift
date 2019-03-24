//
//  FooterCell.swift
//  VK
//
//  Created by Евгений Бижанов on 17/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var repostsImage: UIImageView!
    @IBOutlet weak var repostsLabel: UILabel!
    
    @IBOutlet weak var viewsLabel: UILabel!
    
    var counterDelegate: ((Int) -> String)?
    
    var model: FooterCellModel? {
        willSet {
            setupCell(model: newValue)
        }
    }
    
    func setupCell(model: FooterCellModel?) {
        
        guard let model = model else {
            return
        }
        
        likesImage.image = model.likes.userLikes
            ? R.image.likeActive()
            : R.image.likeInactive()
        likesLabel.text = counterDelegate?(model.likes.count) ?? String(model.likes.count)
        
        repostsImage.image = model.reposts.userReposted
            ? R.image.repostActive()
            : R.image.repostInactive()
        repostsLabel.text = counterDelegate?(model.reposts.count) ?? String(model.reposts.count)
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

struct FooterCellModel {
    let likes: VMLikes
    let reposts: VMReposts
}
