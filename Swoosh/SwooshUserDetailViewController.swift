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
    
    override func viewDidLoad() {
        print("\(user.name)")
    }
    
}
