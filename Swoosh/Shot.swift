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
    let imageUrl: NSURL
    var image: UIImage?
    
    init(id: Int, title: String, description: String, viewsCount: Int, likesCount: Int, imageUrl: NSURL) {
        self.id = id
        self.title = title
        self.description = description
        self.viewsCount = viewsCount
        self.likesCount = likesCount
        self.imageUrl = imageUrl
    }
    
}

extension Shot: Equatable {}

func == (lhs: Shot, rhs: Shot) -> Bool {
    return lhs.id == rhs.id
}


















