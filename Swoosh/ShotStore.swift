//
//  ShotStore.swift
//  Swoosh
//
//  Created by Ariunjargal on 3/21/16.
//  Copyright © 2016 Ariunjargal. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum ShotError: ErrorType {
    case ImageCreationError
}

class ShotStore {
    
    // NSURLSesssion - factory for NSURLSessionTask instances
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    // This method will be called form a class that uses ShotsStore (e.g SwooshViewController)
    func fetchRecentShots(completion completion: (ShotsResult) -> Void) {
        
        // Define URL with recent shots URL
        let url = DribbbleAPI.recentShotsURL()
        
        // Define the request object
        let request = NSURLRequest(URL: url)
        
        // Define NSURLSessionDataTask to request data from dribbble - task will be in suspended state
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            let result = self.processRecentPhotosRequest(data: data, error: error)
            
            completion(result)
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
    
    func fetchTeaserImageForShot(shot: Shot, completion: (ImageResult) -> Void) {
        let shotURL = shot.teaserImageUrl
        let request = NSURLRequest(URL: shotURL)
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                shot.image = image
            }
            
            completion(result)
            
        }
        task.resume()
    }
    
    func fetchNormalImageForShot(shot: Shot, completion: (ImageResult) -> Void) {
        var shotURL = shot.normalImageUrl
        
        if !shot.hidpiImageUrl.absoluteString.isEmpty {
            shotURL = shot.hidpiImageUrl
        }
        
        print("normal: \(shot.normalImageUrl)")
        print("hidpi: \(shot.hidpiImageUrl)")
        
        let request = NSURLRequest(URL: shotURL)
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                shot.image = image
            }
            
            completion(result)
            
        }
        task.resume()
    }
    
    func processImageRequest(data data: NSData?, error: NSError?) -> ImageResult {
        guard let
            imageData = data,
            image = UIImage(data: imageData) else {
                if data == nil {
                    return .Failure(error!)
                }
                else {
                    return .Failure(ShotError.ImageCreationError)
                }
        }
        
        return .Success(image)
    }
    
}