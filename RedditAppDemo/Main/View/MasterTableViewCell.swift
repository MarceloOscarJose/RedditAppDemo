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

    weak var delegate: MasterTableViewCellDelegate?

    // Data vars
    var postIndex: IndexPath = IndexPath(item: 0, section: 0)
    var readed: Bool = false

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
        self.postIndex = postIndex
        self.authorLabel.text = author
        self.createdLabel.text = created
        self.titleLabel.text = title
        self.commentsLabel.text = comments
        self.readed = readed
        self.updateStatus()
    }

    func updateThumbnail(thumbnail: UIImage?) {
        DispatchQueue.main.async {
            self.postThumbnail.image = thumbnail
        }
    }

    func updateStatus() {
        self.readedIndicator.backgroundColor = self.readed ? UIColor.clear : UIColor.ligthBlue
        self.backgroundColor = self.readed ? UIColor.lightText : UIColor.groupTableViewBackground
    }

    @IBAction func dismissPost(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.dismissPost(postIndex: self.postIndex)
        }
    }
}

protocol MasterTableViewCellDelegate: class {
    func dismissPost(postIndex: IndexPath)
}
