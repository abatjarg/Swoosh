//
//  ShotStore.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/21/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import Foundation

class ShotStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentShots() {
        
        let url = DribbbleAPI.recentShotsURL()
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding){
                    print(jsonString)
                }
            }
            else if let requestError = error {
                print("Error fetching recent shots: \(requestError)")
            }
            else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
    
}