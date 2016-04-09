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
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var shotImage: UIImage!
    
    var shot: Shot! {
        didSet {
            navigationItem.title = shot.title
        }
    }
    
    var store: ShotStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.likeCount.text = "Likes: \(shot.likesCount)"
        self.viewCount.text = "Views: \(shot.viewsCount)"
        
        self.userImage.layer.cornerRadius = self.userImage.frame.height / 2.0
        self.userImage.layer.masksToBounds = false
        self.userImage.clipsToBounds = true
        
        self.nameLabel.text = shot.user.name
        self.usernameLabel.text = shot.user.username
        
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(SwooshShotDetailViewController.tapAction(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(doubleTapGesture)
        
        store.fetchUserAvatarImage(shot) {
            (result) -> Void in
            switch result {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.userImage.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        
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
        } else if segue.identifier == "ShowUser" {
            let dVC = segue.destinationViewController as! SwooshUserDetailViewController
            dVC.user = shot.user
        }
    }
    
}
