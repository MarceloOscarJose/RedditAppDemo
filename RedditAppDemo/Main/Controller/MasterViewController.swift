//
//  MasterViewController.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    weak var delegate: PostSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        splitViewController?.delegate = self
        let service = TopPostsService()
        service.fetchTopPosts(afterPost: nil, responseHandler: { (result) in
            print(result)
        }) { (error) in
            print(error)
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
