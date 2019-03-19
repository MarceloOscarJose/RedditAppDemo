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

    // Data vars
    let cellIdentifier = "MasterTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        splitViewController?.delegate = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension MasterViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

protocol PostSelectionDelegate: class {
}
