//
//  PostDataModel.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class PostDataModel: NSObject {

    let topPostsService = TopPostsService()

    var id: String
    var title: String
    var author: String
    var created: String
    var comments: String
    var thumbnail: String
    var preview: String
    var readed: Bool = false
    var dismissed: Bool = false

    init(id: String, title: String, author: String, comments: Int, created: Double, thumbnail: String) {
        let date = Date(timeIntervalSince1970: created)
        self.id = id
        self.title = title
        self.author = author
        self.created = date.timeAgoDisplay()
        self.comments = "\(comments) comments"
        self.thumbnail = thumbnail
        self.preview = ""
    }

    func setPreviewImage(preview: String) {
        self.preview = preview.replacingOccurrences(of: "amp;", with: "")
    }

    func fetchThumbnail(responseHandler: @escaping (_ response: UIImage?) -> Void) {
        fetchImage(url: self.thumbnail) { (image) in
            responseHandler(image)
        }
    }

    func fetchPreview(responseHandler: @escaping (_ response: UIImage?) -> Void) {
        fetchImage(url: self.preview) { (image) in
            responseHandler(image)
        }
    }

    func fetchImage(url: String, responseHandler: @escaping (_ response: UIImage?) -> Void) {
        topPostsService.fetchPostImage(url: url, responseHandler: { (data) in
            responseHandler(UIImage(data: data))
        }) { (_) in
            responseHandler(UIImage(named: "noimage"))
        }
    }

    func cancelFetch() {
        topPostsService.cancelTask()
    }
}
