//
//  SwooshUserDetailViewController.swift
//  Swoosh
//
//  Created by Ariunjargal on 4/6/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class SwooshUserDetailViewController: UIViewController {
    
    var user: User! {
        didSet {
            navigationItem.title = user.name
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = user.image
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
        self.bioLabel.text = user.bio
    }
    
}
