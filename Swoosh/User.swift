//
//  User.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/21/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class User {
    
    let name: String
    let username: String
    let bio: String
    let avatarUrl: NSURL
    var image: UIImage?
    
    init(name: String, username: String, bio: String, avatarUrl: NSURL) {
        self.name = name
        self.username = username
        self.bio = bio
        self.avatarUrl = avatarUrl
    }
    
}