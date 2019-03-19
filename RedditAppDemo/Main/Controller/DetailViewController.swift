//
//  DetailViewController.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, PostSelectionDelegate {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    // Data vars
    var postData: PostDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        postImage.image = nil
    }

    func postSelected(postData: PostDataModel) {

        if self.postData != nil {
            self.postData.cancelFetch()
        }

        postImage.image = UIImage(named: "noimage")
        self.postData = postData

        authorLabel.text = self.postData.author
        titleLabel.text = self.postData.title

        self.postData.fetchPreview { (image) in
            DispatchQueue.main.async {
                self.postImage.image = image
            }
        }
    }
}
