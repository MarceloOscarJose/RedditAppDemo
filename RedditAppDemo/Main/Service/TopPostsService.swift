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
    let pageLimit: Int = 10

    func fetchTopPosts(responseHandler: @escaping (_ response: PostResult) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let url = "\(ConfigManager.sharedInstance.apiURL)\(urlPath)"
        let params: [String: String] = ["limit": "\(pageLimit)"]

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
}
