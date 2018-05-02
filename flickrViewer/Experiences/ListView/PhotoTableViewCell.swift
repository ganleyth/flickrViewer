//
//  PhotoTableViewCell.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 5/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        photoImageView.image = #imageLiteral(resourceName: "defaultPhoto")
    }
    
    func configure(with photo: Photo) {
        descriptionLabel.text = photo.title
        if let imageURL = photo.imageURL {
            photoImageView.loadImage(at: imageURL)
        }
    }
}
