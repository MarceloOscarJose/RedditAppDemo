//
//  PostResult.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import Foundation

struct PostResult: Codable {
    var data: Data

    struct Data: Codable {
        var after: String
        var children: [PostChildren]
    }
}

public struct PostChildren: Codable {
    var data: PostData
}

public struct PostData: Codable {
    var id: String
    var title: String
    var author: String
    var comments: Int
    var created: Double
    var thumbnail: String
    var preview: Preview?

    struct Preview: Codable {
        var images: [PreviewImage]?

        struct PreviewImage: Codable {
            var source: PreviewImageSource?

            struct PreviewImageSource: Codable {
                var url: String
            }
        }
    }

    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case author = "author_fullname"
        case comments = "num_comments"
        case created
        case thumbnail
        case preview
    }
}
