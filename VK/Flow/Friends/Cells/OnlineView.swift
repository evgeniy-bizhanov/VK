//
//  OnlineView.swift
//  VK
//
//  Created by Евгений Бижанов on 13/02/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class OnlineView: UITableViewCell, PersonViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var title: UILabel!
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
        
        title.attributedText = model.constructFullName(ofSize: title.font.pointSize)
        if let url = URL(string: model.image) {
            profileImage.kf.setImage(with: url)
        }
    }
    
    
    // MARK: - Initializers
}

extension VMPerson {
    func constructFullName(ofSize size: CGFloat) -> NSAttributedString {
        
        let fullName = (firstName + " " + lastName)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        let attributedFullName = NSMutableAttributedString(string: fullName)
        let range = NSRange(
            location: firstName != "" ? firstName.count + 1 : 0,
            length: lastName.count
        )
        
        let font = UIFont.systemFont(ofSize: size, weight: .medium)
        attributedFullName.setAttributes(
            [NSAttributedString.Key.font: font],
            range: range
        )
        
        return attributedFullName
    }
}
