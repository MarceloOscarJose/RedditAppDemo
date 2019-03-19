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

    lazy var tableRefreshControl: UIRefreshControl = {
        let tableRefreshControl = UIRefreshControl()
        tableRefreshControl.tintColor = UIColor.ligthBlue
        tableRefreshControl.addTarget(self, action: #selector(getTopPost), for: .valueChanged)
        return tableRefreshControl
    }()
    lazy var tableButtonRefreshControl: UIActivityIndicatorView = {
        let tableButtonRefreshControl = UIActivityIndicatorView(style: .gray)
        tableButtonRefreshControl.color = UIColor.ligthBlue
        tableButtonRefreshControl.hidesWhenStopped = true
        tableButtonRefreshControl.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100)
        return tableButtonRefreshControl
    }()

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
        tableView.refreshControl = tableRefreshControl
        tableView.tableFooterView = tableButtonRefreshControl
    }

    @objc func getTopPost(nextPage: Bool = false) {
        self.tableButtonRefreshControl.startAnimating()

        postsModel.getTopPosts(nextPage: nextPage, responseHandler: {
            DispatchQueue.main.async {
                self.tableRefreshControl.endRefreshing()
                self.tableView.reloadData()
                self.tableButtonRefreshControl.stopAnimating()
            }
        }) { (error) in
            print("Connection error")
        }
    }

    func shouldUpdatePosts(indexPath: IndexPath) {
        if indexPath.row == postsModel.posts.count - 1 {
            self.getTopPost(nextPage: true)
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
