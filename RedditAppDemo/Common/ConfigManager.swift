//
//  ConfigManager.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class ConfigManager: NSObject {

    static let sharedInstance = ConfigManager()

    // Config vars
    var apiURL = ""

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let nsDictionary: NSDictionary = NSDictionary(contentsOfFile: path) {
                self.apiURL = nsDictionary["ApiURL"] as! String
            }
        }
    }
}
