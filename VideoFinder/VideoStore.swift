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
    var videoDetailsDict = [String:String]()
    let myNetworkmanager = NetworkDataManager.sharedNetworkmanager
    let myUtilities = Utilities.sharedUtility

    func searchMovieDataWithKeyWord(_ keyWord: String, year: String, completion:@escaping (_ success: Bool) -> Void) {
        var paramDict = [String:String]()
        if(!keyWord.isEmpty ) {

            paramDict[kSearchParamKey] = keyWord
        }
        if(!year.isEmpty) {
            paramDict[kYearParamKey] = year
        }

        paramDict[kPlotParamKey]     = "full"
        paramDict[kResponseParamKey] = "json"
        if(!paramDict.isEmpty) {

            let url = myUtilities.buildQueryString(fromDictionary: paramDict)

            print(url)
            let webUrl = URL(string: url)

            let urlRequest = URLRequest(url: webUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 2.0)
            myNetworkmanager.fetchDataWithUrlRequest(urlRequest) { (success, fetchedData) -> Void in
                if let data = fetchedData as? [String:Any] {
                    print(data["Search"])
                    if let vidData = data["Search"] as? [Any] {
                        for videoDict in vidData {
                            let video = Video(videoData: videoDict as! Dictionary<String, String>)
                            self.videoArray.append(video!)
                        }
                        completion(true)
                    }

                }

            }
        }

    }

    func searchVideoBy(_ imdbId: String, includeRottenTomatoRatings: Bool, withCompletion completion:@escaping (_ success: Bool) -> Void) {
        var paramDict = [String:String]()
        if(!imdbId.isEmpty ) {

            paramDict[kImdbIDParamKey] = imdbId
        }
        if(includeRottenTomatoRatings) {
            paramDict[kIncludeTomatoParamKey] = "true"
        } else {
            paramDict[kIncludeTomatoParamKey] = "false"
        }
        paramDict[kPlotParamKey]     = "full"
        paramDict[kResponseParamKey] = "json"
        if(!paramDict.isEmpty) {

            let url = myUtilities.buildQueryString(fromDictionary: paramDict)

            print(url)
            let webUrl = URL(string: url)
            let urlRequest = URLRequest(url: webUrl!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 2.0)
            myNetworkmanager.fetchDataWithUrlRequest(urlRequest) { (success, fetchedData) -> Void in
                if let data = fetchedData as? Dictionary<String, String> {
                    print(data)
                    self.videoDetailsDict = data
                    completion(true)
                }

            }
        }
    }
}
