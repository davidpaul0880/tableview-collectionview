//
//  CollectionViewCell.swift
//  tableview-collectionview
//
//  Created by Jijo A Pulikkottil on 07/11/16.
//  Copyright © 2016 david. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    func configureCellWithBrand(section: Int, brand: String, indexPath: IndexPath) {
        
        self.imgView.image = UIImage(named: "car")
    }
}
