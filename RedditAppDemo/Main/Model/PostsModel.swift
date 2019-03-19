//
//  PostsModel.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import CoreData

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

                if let preview = post.data.preview, let previewImages = preview.images, let previewSource = previewImages[0].source {
                    dataModel.setPreviewImage(preview: previewSource.url)
                }

                self.posts.append(dataModel)
            }

            let postEntity = self.fetchPosts()

            if postEntity.count > 0 {
                self.posts = self.posts.map { (element) -> PostDataModel in
                    if postEntity.contains(where: { $0.id == element.id && $0.readed }) {
                        element.readed = true
                    }

                    return element
                }
            }

            responseHandler()
        }) { (error) in
            errorHandler(error)
        }
    }

    public func savePostsSatus(posts: [PostDataModel]) {
        let backgroundContext = PersistenceManager.sharedInstance.persistentContainer.newBackgroundContext()
        PersistenceManager.sharedInstance.persistentContainer.viewContext.mergePolicy = NSMergePolicy(merge: NSMergePolicyType.mergeByPropertyObjectTrumpMergePolicyType)
        PersistenceManager.sharedInstance.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

        for post in posts {
            let postData = PersistenceManager.sharedInstance.fetchById(Post.self, id: post.id)

            backgroundContext.perform {
                do {
                    if postData.count > 0 {
                        postData[0].setValue(post.readed, forKey: "readed")
                        postData[0].didSave()
                    } else {
                        let postEntity = Post(context: backgroundContext)
                        postEntity.id = post.id
                        postEntity.readed = post.readed
                        postEntity.didSave()
                    }
                    try backgroundContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }

    private func fetchPosts() -> [Post] {
        let posts = PersistenceManager.sharedInstance.fetch(Post.self, sortBy: "id", ascending: true)
        if posts.count > 0 {
            return posts
        } else {
            return []
        }
    }

    func setReadedPost(index: Int) {
        self.posts[index].readed = true
        self.savePostsSatus(posts: [self.posts[index]])
    }

    func removePost(index: Int) {
        self.posts.remove(at: index)
    }

    func removeAllPosts() {
        self.posts.removeAll()
    }
}
