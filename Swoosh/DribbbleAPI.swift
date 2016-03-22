//
//  DribbbleAPI.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/18/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentShots = "sort=recent"
}

struct DribbbleAPI {
    
    // Full url: https://api.dribbble.com/v1/shots?access_token=5938b1029b9fceeda8b683154b241ee91c43ae874769234687658e3cbaa4becd&sort=recent
    
    static let baseURLString = "https://api.dribbble.com/v1/shots"
    
    private static let access_token = "5938b1029b9fceeda8b683154b241ee91c43ae874769234687658e3cbaa4becd"
    
    private static func dribbbleURL(method method: Method, parameters: [String:String]?) -> NSURL {
        
        let components = NSURLComponents(string: baseURLString)!
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "access_token" : access_token
        ]
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        
        return components.URL!
    }
    
    static func recentShotsURL() -> NSURL {
        return dribbbleURL(method: .RecentShots, parameters: ["sort":"recent"])
    }
}
