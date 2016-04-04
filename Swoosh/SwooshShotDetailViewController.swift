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
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var shot: Shot! {
        didSet {
            navigationItem.title = shot.title
        }
    }
    
    var store: ShotStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(SwooshShotDetailViewController.tapAction(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(doubleTapGesture)
        
        store.fetchNormalImageForShot(shot) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        
        self.likeCount.text = "\(shot.likesCount)"
        self.viewCount.text = "\(shot.viewsCount)"
    }
    
    func tapAction(gestureRecognizer: UITapGestureRecognizer)
    {
        print("tap")
        self.performSegueWithIdentifier("ShowImage", sender: self)
    }
    
}
