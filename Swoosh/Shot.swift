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
    var image: UIImage?
    
    init(id: Int, title: String, description: String, viewsCount: Int, likesCount: Int, teaserImageUrl: NSURL, normalImageUrl: NSURL) {
        self.id = id
        self.title = title
        self.description = description
        self.viewsCount = viewsCount
        self.likesCount = likesCount
        self.teaserImageUrl = teaserImageUrl
        self.normalImageUrl = normalImageUrl
    }
    
}

extension Shot: Equatable {}

func == (lhs: Shot, rhs: Shot) -> Bool {
    return lhs.id == rhs.id
}


















