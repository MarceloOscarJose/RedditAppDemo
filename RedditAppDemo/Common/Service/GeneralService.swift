//
//  GeneralService.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

class GeneralService: NSObject {
    
    let defaultSession = URLSession.shared
    var dataTask: URLSessionDataTask!
    
    func executeRequest(url: String, paramaters: [String: String]?, responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        if var urlComponents = URLComponents(string: url) {

            if let params = paramaters {
                urlComponents.queryItems = params.map { (key, value) -> URLQueryItem in
                    return URLQueryItem(name: key, value: value)
                }
                urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            }

            if let finalURL = urlComponents.url {
                var request = URLRequest(url: finalURL)
                request.httpMethod = "GET"

                self.dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
                    guard let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode, error == nil else {
                        errorHandler(error)
                        return
                    }
                    responseHandler(data)
                }

                self.dataTask.resume()
                return
            }
        }

        errorHandler(nil)
    }
    
    func cancelTask() {
        dataTask.cancel()
    }
}
