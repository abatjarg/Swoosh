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
    
    var shotImage: UIImage!
    
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
                    self.shotImage = image
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }

    }
    
    func tapAction(gestureRecognizer: UITapGestureRecognizer)
    {
        print("tap")
        self.performSegueWithIdentifier("ShowImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowImage" {
            let dVC = segue.destinationViewController as! SwooshShotImageViewController
            dVC.shotImage = self.shotImage
        }
    }
    
}
