//
//  Shot.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/21/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

class Shot {
    
    let id: Int
    let title: String
    let description: String
    let viewsCount: Int
    let likesCount: Int
    let teaserImageUrl: NSURL
    let normalImageUrl: NSURL
    let hidpiImageUrl: NSURL
    var image: UIImage?
    let user: User
    
    init(id: Int, title: String, description: String, viewsCount: Int, likesCount: Int, teaserImageUrl: NSURL, normalImageUrl: NSURL, hidpiImageUrl: NSURL, user: User) {
        self.id = id
        self.title = title
        self.description = description
        self.viewsCount = viewsCount
        self.likesCount = likesCount
        self.teaserImageUrl = teaserImageUrl
        self.normalImageUrl = normalImageUrl
        self.hidpiImageUrl = hidpiImageUrl
        self.user = user
    }
    
}

extension Shot: Equatable {}

func == (lhs: Shot, rhs: Shot) -> Bool {
    return lhs.id == rhs.id
}


















