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

    var postData: PostDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    func setupControls() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentSaveImage))
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tapGesture)
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

    @objc func presentSaveImage() {
        if let image = postImage.image, image != UIImage(named: "noimage") {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        if let error = error {
            alert.title = "Save error"
            alert.message = error.localizedDescription
        } else {
            alert.title = "Saved"
            alert.message = "The image has been saved to your photos"
        }

        present(alert, animated: true)
    }
}
