//
//  SwooshShotDetailViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 4/2/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshShotDetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var shot: Shot! {
        didSet {
            navigationItem.title = shot.title
        }
    }
    
    var store: ShotStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchNormalImageForShot(shot) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    
}
