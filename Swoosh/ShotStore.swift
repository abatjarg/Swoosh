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
    
    // This method will be called form a class that uses ShotsStore (e.g SwooshViewController)
    func fetchRecentShots() {
        
        // Define URL with recent shots URL
        let url = DribbbleAPI.recentShotsURL()
        
        // Define the request object
        let request = NSURLRequest(URL: url)
        
        // Define NSURLSessionDataTask to request data from dribbble - task will be in suspended state
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            let result = self.processRecentPhotosRequest(data: data, error: error)
            
            print(result)
        }
        // This will start the api request to the service
        task.resume()
    }
    
    func processRecentPhotosRequest(data data: NSData?, error: NSError?) -> ShotsResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return DribbbleAPI.photosFromJSONData(jsonData)
    }
    
}