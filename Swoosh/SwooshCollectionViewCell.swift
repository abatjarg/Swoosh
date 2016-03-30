//
//  SwooshCollectionViewCell.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/18/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func updateWithImage(image: UIImage?) {
        if let imageToDisplay = image {
            imageView.image = imageToDisplay
        }
        else
        {
            imageView.image = nil 
        }
    }
}
