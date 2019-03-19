//
//  MasterViewController.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, MasterTableViewCellDelegate {

    weak var delegate: PostSelectionDelegate?

    // Data vars
    let postsModel = PostsModel()
    let cellIdentifier = "MasterTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
        getTopPost(nextPage: false)
    }

    func setupControls() {
        splitViewController?.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    func getTopPost(nextPage: Bool = false) {
        postsModel.getTopPosts(nextPage: nextPage, responseHandler: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            print("Connection error")
        }
    }

    func dismissPost(postIndex: IndexPath) {
        self.postsModel.removePost(index: postIndex.item)

        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [postIndex], with: .middle)
            self.tableView.reloadData()
        }
    }

    @IBAction func dismissAll(_ sender: Any) {
        self.postsModel.removeAllPosts()

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.getTopPost(nextPage: true)
        }
    }
}

extension MasterViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

protocol PostSelectionDelegate: class {
}
