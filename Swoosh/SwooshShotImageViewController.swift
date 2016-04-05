//
//  SwooshShotImageViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 4/4/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshShotImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var shotImage: UIImage!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = shotImage
    }
    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        if let view = imageView {
            imageView.transform = CGAffineTransformScale(view.transform,
                                                    recognizer.scale, recognizer.scale)
            recognizer.scale = 1
            
        }
    }
}
