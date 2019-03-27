//
//  PhotoCell.swift
//  VK
//
//  Created by Евгений Бижанов on 17/03/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell, Identifiable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var dataSource: UICollectionViewDataSource!
    weak var delegate: UICollectionViewDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
