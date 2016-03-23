//
//  ShotStore.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/21/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import Foundation

class ShotStore {
    
    // NSURLSesssion - factory for NSURLSessionTask instances
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    func fetchRecentShots() {
        
        // Define URL with recent shots URL
        let url = DribbbleAPI.recentShotsURL()
        
        // Define the request object
        let request = NSURLRequest(URL: url)
        
        // Define NSURLSessionDataTask to request data from dribbble - task will be in suspended state
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if let jsonData = data {
                do {
                    let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    print(jsonObject)
                }
                catch let error {
                    print("Error creating JSON object: \(error)")
                }
            }
            else if let requestError = error {
                print("Error fetching recent shots: \(requestError)")
            }
            else {
                print("Unexpected error with the request")
            }
        }
        // This will start the api request to the service
        task.resume()
    }
    
}