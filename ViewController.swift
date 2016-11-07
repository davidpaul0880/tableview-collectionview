//
//  ViewController.swift
//  tableview-collectionview
//
//  Created by Jijo A Pulikkottil on 07/11/16.
//  Copyright © 2016 david. All rights reserved.
//

import UIKit

var GlobalMainQueue: DispatchQueue {
    return DispatchQueue.main
}

class Category {
    
    
    var name: String
    var items: [String]
    
    required init(json: [String: Any]) {
        
        
        self.name = json["name"] as! String
        self.items = json["items"] as! [String]
    }
}



class ViewController: UIViewController {
    
    var storedOffsets = [Int: CGFloat]()
    var categories: [Category] = [Category]()
    
    func loadData(){
        
        let items1 = ["imageurl1", "imageurl2"]
        let items2 = ["imageurl1", "imageurl2", "imageurl1", "imageurl2", "imageurl1", "imageurl2"]
        let items3 = ["imageurl1", "imageurl2", "imageurl1", "imageurl2"]
        let tobejson = [
            "Categories":
                [
                    [
                        "name": "Car",
                        "items": items1
                        
                    ],
                    [
                        "name": "Real Estates",
                        "items": items2
                    ],
                    [
                        "name": "Pets",
                        "items": items3
                    ]
            ]
        ]
        
        categories = tobejson["Categories"]!.map { (jsonDict) -> Category in
            return Category(json: jsonDict)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeTableCell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        //homeTableCell.delegate = self
        return homeTableCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HomeTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row, headerName: categories[indexPath.row].name)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HomeTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
}



//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard categories.count > collectionView.tag else { return 0 }
        return categories[collectionView.tag].items.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
        let brand = categories[collectionView.tag].items[indexPath.row]
        cell.configureCellWithBrand(section: collectionView.tag, brand: brand, indexPath: indexPath)
        //cell.delegate = self
        
        return cell
    }
    
}
