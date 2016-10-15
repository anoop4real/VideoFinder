//
//  NetworkDataManager.swift
//  MyMusic
//
//  Created by anoopm on 17/05/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class NetworkDataManager: NSObject {

    // Singleton instance
    static let sharedNetworkmanager = NetworkDataManager()

    // Save images in cache
    static let sharedCache: NSCache = {
        let cache = NSCache()
        cache.name = "MyImageCache"
        cache.countLimit = 20 // Max 20 images in memory.
        cache.totalCostLimit = 10*1024*1024 // Max 10MB used.
        return cache
    }()
    // Create a session
    let session: NSURLSession = {

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()

        return NSURLSession(configuration: config)
    }()

    // Method to fetch data from URL
    func fetchDataWithUrl(url: NSURL, completion:(success: Bool, fetchedData: AnyObject) -> Void) {


        let urlRequest = NSMutableURLRequest(URL: url)
        let task = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if error != nil {
                print(error?.description)
            } else {
                do {
                    let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    completion(success: true, fetchedData: jsonObject)
                } catch {
                    print("Error")
                }
            }
        }
        task.resume()

    }
}
extension NSURL {

    typealias ImageCacheCompletion = UIImage -> Void

    /// Retrieves a pre-cached image, or nil if it isn't cached.
    /// You should call this before calling fetchImage.
    var cachedImage: UIImage? {
        return NetworkDataManager.sharedCache.objectForKey(
            absoluteString) as? UIImage
    }
    func isValidUrl() -> Bool {

        if(self.scheme.hasPrefix("http") || self.scheme.hasPrefix("https")) {
            return true
        }
        return false
    }
    /// Fetches the image from the network.
    /// Stores it in the cache if successful.
    /// Only calls completion on successful image download.
    /// Completion is called on the main thread.
    func fetchImage(completion: ImageCacheCompletion) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(self) {
            data, response, error in
            if error == nil {
                if let  data = data,
                    image = UIImage(data: data) {
                        NetworkDataManager.sharedCache.setObject(
                            image,
                            forKey: self.absoluteString,
                            cost: data.length)
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(image)
                        }
                }
            }
        }
        task.resume()
    }

}

extension String {

    func isValidForUrl() -> Bool {

        if(self.hasPrefix("http") || self.hasPrefix("https")) {
            return true
        }
        return false
    }
}
