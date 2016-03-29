//
//  SwooshDataSource.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/16/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshDataSource: NSObject, UICollectionViewDataSource {
    
    var shots = [Shot]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shots.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! SwooshCollectionViewCell
        
        cell.imageView.image = shots[indexPath.row].image
        
        return cell
    }
    
}
