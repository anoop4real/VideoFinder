//
//  Video.swift
//  VideoFinder
//
//  Created by anoopm on 22/06/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

struct Video {
    
    var title:String! // Title of movie
    var year:String!
    var imdbId:String!
    var type:String! // Video type. Movie, episode etc
    var posterURL:String!
    
    init?(videoData:Dictionary<String,String>){
        
        guard
            let title  = videoData["Title"],
            let year = videoData["Year"],
            let imdbId = videoData["imdbID"]
        else {
            
            return nil
        }
        
        self.title  = title
        self.year   = year
        self.imdbId = imdbId
        
        guard
            let type  = videoData["Type"],
            let posterURL = videoData["Poster"]
            else {
                
                self.type = nil
                self.posterURL = nil
                return
        }
        
        self.type = type
        self.posterURL = posterURL
    }
}
