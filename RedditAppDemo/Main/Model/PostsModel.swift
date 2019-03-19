//
//  PostsModel.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class PostsModel: NSObject {
    let topPostsService = TopPostsService()

    // Data vars
    var posts: [PostDataModel] = []
    var afterPost: String?

    func getTopPosts(nextPage: Bool, responseHandler: @escaping () -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        if !nextPage {
            posts = []
            self.afterPost = nil
        }

        topPostsService.fetchTopPosts(afterPost: afterPost, responseHandler: { (result) in
            self.afterPost = result.data.after

            for post in result.data.children {

                let dataModel = PostDataModel(id: post.data.id,
                  title: post.data.title,
                  author: post.data.author,
                  comments: post.data.comments,
                  created: post.data.created,
                  thumbnail: post.data.thumbnail
                )

                self.posts.append(dataModel)
            }
            responseHandler()
        }) { (error) in
            errorHandler(error)
        }
    }
}
