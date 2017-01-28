//
//  Utilities.swift
//  VideoFinder
//
//  Created by anoopm on 21/06/16.
//  Copyright © 2016 anoopm. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static let sharedUtility = Utilities()

    func buildQueryString(fromDictionary parameters: [String:String]) -> String {
        var urlVars: [String] = []

        for (key, value) in parameters {
            if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                urlVars.append(key + "=" + encodedValue)
            }
        }
        let url = urlVars.isEmpty ? "" : "?" + urlVars.joined(separator: "&")
        return kAppBaseURL+url
    }
}
