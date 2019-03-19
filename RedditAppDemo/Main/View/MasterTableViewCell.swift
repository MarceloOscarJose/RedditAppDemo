//
//  MasterTableViewCell.swift
//  RedditAppDemo
//
//  Created by Marcelo José on 19/03/2019.
//  Copyright © 2019 Marcelo José. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    @IBOutlet weak var readedIndicator: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var postThumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        readedIndicator.layer.cornerRadius = readedIndicator.frame.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postThumbnail.image = nil
    }

    func updateCell(postIndex: IndexPath, author: String, created: String, title: String, comments: String, readed: Bool) {
        self.authorLabel.text = author
        self.createdLabel.text = created
        self.titleLabel.text = title
        self.commentsLabel.text = comments
    }

    func updateThumbnail(thumbnail: UIImage?) {
        DispatchQueue.main.async {
            self.postThumbnail.image = thumbnail
        }
    }
}
