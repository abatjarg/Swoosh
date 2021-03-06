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
    case MostViewedShots = "sort=views"
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
    static let baseURLString = "https://api.dribbble.com/v1/users"
    
    // Dribbble access token
    private static let access_token = "5938b1029b9fceeda8b683154b241ee91c43ae874769234687658e3cbaa4becd"
    
    // Construct the URL
    private static func dribbbleURL(baseUrl: NSURL,method method: Method, parameters: [String:String]?) -> NSURL {
        
        let components = NSURLComponents(string: baseURLString)!
        
        // Defines the query item in the URL seperated by "?" (key, value) pair
        var queryItems = [NSURLQueryItem]()
        
        let baseParams = [
            "access_token" : access_token,
            "per_page"     : "50"
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
    
    // https://api.dribbble.com/v1/users/21158/shots?access_token=5938b1029b9fceeda8b683154b241ee91c43ae874769234687658e3cbaa4becd&per_page=100
    
    static func userShotsURL() -> NSURL {
        return dribbbleURL(method: <#T##Method#>, parameters: <#T##[String : String]?#>)
    }
    
    static func recentShotsURL() -> NSURL {
        return dribbbleURL(method: .RecentShots, parameters: ["sort":"recent"])
    }
    
    static func mostCommentedShotsURL() -> NSURL {
        return dribbbleURL(method: .MostCommentedShots, parameters: ["sort":"comments"])
    }
    
    static func mostViewedShotsURL() -> NSURL {
        return dribbbleURL(method: .MostViewedShots, parameters: ["sort":"views"])
    }

    
    // To-do: Add guard statement to protect against invaled JSON
    static func photosFromJSONData(data: NSData) -> ShotsResult {
        
            let jsonObject = JSON(data: data)
            
            var finalShots = [Shot]()
            
            for (_, shotJson) in jsonObject {
                let shotId = shotJson["id"].intValue
                let title = shotJson["title"].stringValue
                let description = shotJson["description"].stringValue
                let viewsCount = shotJson["views_count"].intValue
                let likesCount = shotJson["likes_count"].intValue
                let teaserImageUrl = shotJson["images"]["teaser"].stringValue
                let hidpiImageUrl = shotJson["images"]["hidpi"].stringValue
                let normalImageUrl = shotJson["images"]["normal"].stringValue
                
                let name = shotJson["user"]["name"].stringValue
                let username = shotJson["user"]["username"].stringValue
                let bio = shotJson["user"]["bio"].stringValue
                let avatarUrl = shotJson["user"]["avatar_url"].stringValue
                
                let user = User(name: name, username: username, bio: bio, avatarUrl: NSURL(string: avatarUrl)!)
                
                finalShots.append(Shot(id: shotId, title: title, description: description, viewsCount: viewsCount, likesCount: likesCount, teaserImageUrl: NSURL(string: teaserImageUrl)!, normalImageUrl: NSURL(string: normalImageUrl)!, hidpiImageUrl: NSURL(string: hidpiImageUrl)!, user: user))
            }
            
            return .Success(finalShots)
    }
}










