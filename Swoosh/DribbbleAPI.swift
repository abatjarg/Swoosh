//
//  DribbbleAPI.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/18/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import Foundation
import SwiftyJSON


// Below will define how to get the information back
enum Method: String {
    case RecentShots = "sort=recent"
    case MostCommentedShots = "sort=comments"
    
}

enum ShotsResult {
    case Success([Shot])
    case Failure(ErrorType)
}

enum DribbleError: ErrorType {
    case InvalidJSONData
}

// The DribbbleAPI struct will be responsible for knowing and handling all Dribbble related information:
//  - Generate URLs that Dribble API expects
//  - Know the format of incoming JSON and parse into model objects
//  - It will not be responsible for actual API calls. ShotStore will be doing the API calls.


struct DribbbleAPI {
    
    // Base API URL
    static let baseURLString = "https://api.dribbble.com/v1/shots"
    
    // Dribbble access token
    private static let access_token = "5938b1029b9fceeda8b683154b241ee91c43ae874769234687658e3cbaa4becd"
    
    // Construct the URL
    private static func dribbbleURL(method method: Method, parameters: [String:String]?) -> NSURL {
        
        let components = NSURLComponents(string: baseURLString)!
        
        // Defines the query item in the URL seperated by "?" (key, value) pair
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
    
    static func mostCommentedShotsURL() -> NSURL {
        return dribbbleURL(method: .MostCommentedShots, parameters: ["sort":"comments"])
    }
    
    static func photosFromJSONData(data: NSData) -> ShotsResult {
        do {
            let json = JSON(data: data)
            
            var finalShots = [Shot]()
            
            for (_,subJson):(String, JSON) in json {
                let id = subJson["id"].intValue
                let title = subJson["title"].stringValue
                let description = subJson["description"].stringValue
                let viewsCount = subJson["views_count"].intValue
                let likesCount = subJson["likes_count"].intValue
                let imageUrls = subJson["images"]
                let imageUrl = NSURL(string: imageUrls["normal"].stringValue)!
                let shot = Shot(id: id, title: title, description: description, viewsCount: viewsCount, likesCount: likesCount, imageUrl: imageUrl)
                finalShots.append(shot)
            }
            
            return .Success(finalShots)
        }
        catch let error {
            return .Failure(error)
        }
    }
}










