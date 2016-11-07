//
//  HomeTableViewCell.swift
//  tableview-collectionview
//
//  Created by Jijo A Pulikkottil on 07/11/16.
//  Copyright © 2016 david. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var items: [String] = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(items: [String]) {
        self.items = items
        collectionView.reloadData()
    }

}


//MARK: - UICollectionViewDataSource

extension HomeTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        let brand = items[indexPath.row]
        cell.configureCellWithBrand(section: collectionView.tag, brand: brand, indexPath: indexPath)
        //cell.delegate = self
        
        return cell
    }
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK:- UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //delegate?.selectedItemAt(collectionView.tag, index: indexPath.row)
        
    }

    
}



extension HomeTableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource>(dataSourceDelegate: D, forRow row: Int, headerName: String) { // UICollectionViewDelegate
        
        collectionView.delegate = self
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated: false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
        
    }
    
    func reloadItemAtIndex(index: Int) {
        
        
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        
        get {
            return collectionView.contentOffset.x
        }
    }
}

