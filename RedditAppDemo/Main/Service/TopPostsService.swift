//
//  TopPostsService.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class TopPostsService: GeneralService {

    let urlPath: String = "/top/.json"
    let pageLimit: Int = 50

    func fetchTopPosts(afterPost: String?, responseHandler: @escaping (_ response: PostResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let url = "\(ConfigManager.sharedInstance.apiURL)\(urlPath)"
        var params: [String: String] = ["limit": "\(pageLimit)"]

        if let after = afterPost {
            params.updateValue(after, forKey: "after")
        }

        self.executeRequest(url: url, paramaters: params, responseHandler: { (data) in
            do {
                let postResult = try JSONDecoder().decode(PostResult.self, from: data)
                responseHandler(postResult)
            } catch {
                errorHandler(nil)
            }
        }) { (error) in
            errorHandler(error)
        }
    }

    func fetchPostImage(url: String, responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        self.executeRequest(url: url, paramaters: nil, responseHandler: { (data) in
            responseHandler(data)
        }) { (error) in
            errorHandler(error)
        }
    }
}
