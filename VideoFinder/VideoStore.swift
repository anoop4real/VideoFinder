//
//  VideoStore.swift
//  VideoFinder
//
//  Created by anoopm on 22/06/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class VideoStore: NSObject {

    var videoArray  = [Video]()
    let myNetworkmanager = NetworkDataManager.sharedNetworkmanager
    let myUtilities = Utilities.sharedUtility
    
    func searchMovieDataWithKeyWord(keyWord:String, year:String, completion:(success:Bool)->Void)
    {
        var paramDict = [String:String]()
        if(!keyWord.isEmpty )
        {
            
            paramDict[kSearchParamKey] = keyWord
        }
        if(!year.isEmpty)
        {
            paramDict[kYearParamKey] = year
        }
        
        paramDict[kPlotParamKey]     = "full"
        paramDict[kResponseParamKey] = "json"
        if(!paramDict.isEmpty)
        {
            
            let url = myUtilities.buildQueryString(fromDictionary: paramDict)
            
            print(url)
            let webUrl = NSURL(string: url)

            myNetworkmanager.fetchDataWithUrl(webUrl!) { (success, fetchedData) -> Void in
                if let data = fetchedData["Search"] as? Array<AnyObject>{
                    print(data)
                    for videoDict in data{
                        let video = Video(videoData: videoDict as! Dictionary<String,String>)
                        self.videoArray.append(video!)
                    }
                    completion(success: true)
                }
                
            }
        }
        
    }
    
    func searchVideoBy(imdbId:String, includeRottenTomatoRatings:Bool, withCompletion completion:(success:Bool)->Void)
    {
        var paramDict = [String:String]()
        if(!imdbId.isEmpty )
        {
            
            paramDict[kImdbIDParamKey] = imdbId
        }
        if(includeRottenTomatoRatings)
        {
            paramDict[kIncludeTomatoParamKey] = "true"
        }else
        {
            paramDict[kIncludeTomatoParamKey] = "false"
        }
        paramDict[kPlotParamKey]     = "full"
        paramDict[kResponseParamKey] = "json"
        if(!paramDict.isEmpty)
        {
            
            let url = myUtilities.buildQueryString(fromDictionary: paramDict)
            
            print(url)
            let webUrl = NSURL(string: url)
            
            myNetworkmanager.fetchDataWithUrl(webUrl!) { (success, fetchedData) -> Void in
                if let data = fetchedData as? Dictionary<String,String>{
                    print(data)

                    completion(success: true)
                }
                
            }
        }
    }
}
