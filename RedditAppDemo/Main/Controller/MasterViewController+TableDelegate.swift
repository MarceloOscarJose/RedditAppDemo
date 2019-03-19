//
//  MasterViewController+TableDelegate.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

extension MasterViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsModel.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MasterTableViewCell
        let postData = postsModel.posts[indexPath.item]

        if cell.postThumbnail.image == nil {
            postData.fetchThumbnail { (image) in
                cell.updateThumbnail(thumbnail: image)
            }
        }

        cell.updateCell(postIndex: indexPath, author: postData.author, created: postData.created, title: postData.title, comments: postData.comments, readed: postData.readed)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let detailViewController = delegate as? DetailViewController {
            let postData = postsModel.posts[indexPath.item]

            let cell = tableView.cellForRow(at: indexPath) as! MasterTableViewCell

            tableView.reloadRows(at: [indexPath], with: .automatic)

            splitViewController?.showDetailViewController(detailViewController, sender: nil)
            detailViewController.postSelected(postData: postData)
        }
    }
}
