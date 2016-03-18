//
//  SwooshDataSource.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/16/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshDataSource: NSObject, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! SwooshCollectionViewCell
        
        cell.imageView.image = UIImage(named: "image1.png")
        
        return cell
    }
    
}
