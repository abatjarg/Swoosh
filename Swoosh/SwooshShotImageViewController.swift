//
//  SwooshShotImageViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 4/4/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshShotImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrolllView: UIScrollView!
    @IBOutlet var imageView: UIImageView!
    
    var shotImage: UIImage!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = shotImage
        
        self.scrolllView.minimumZoomScale = 1.0
        self.scrolllView.maximumZoomScale = 6.0
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
