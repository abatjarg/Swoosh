//
//  SwooshUserDetailViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 4/6/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshUserDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var user: User! {
        didSet {
            navigationItem.title = user.name
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.imageView.image = user.image
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
        self.bioLabel.text = user.bio
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        return cell
    }
    
}
