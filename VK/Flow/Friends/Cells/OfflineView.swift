//
//  OfflineView.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit
import Kingfisher

class OfflineView: UITableViewCell, PersonViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var isOnline: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    // MARK: - Models
    
    var model: VMPerson? {
        didSet {
            assignModel(model)
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
    
    func assignModel(_ model: VMPerson?) {
        
        guard let model = model else {
            return
        }
        
        title.attributedText = constructFullName(model)
        isOnline.isHidden = !model.isOnline
        if let url = URL(string: model.image) {
            profileImage.kf.setImage(with: url)
        }
    }
    
    
    // MARK: - Initializers
}

extension OfflineView {
    fileprivate func constructFullName(_ model: VMPerson) -> NSAttributedString {
        let fullName = (model.firstName + " " + model.lastName)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let attributedFullName = NSMutableAttributedString(string: fullName)
        let range = NSRange(
            location: model.firstName != "" ? model.firstName.count + 1 : 0,
            length: model.lastName.count
        )
        
        let font = UIFont.systemFont(ofSize: title.font.pointSize, weight: .medium)
        attributedFullName.setAttributes(
            [NSAttributedString.Key.font: font],
            range: range
        )
        
        return attributedFullName
    }
}
