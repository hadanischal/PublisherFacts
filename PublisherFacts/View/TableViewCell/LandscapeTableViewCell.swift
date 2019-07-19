//
//  LandscapeTableViewCell.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/25/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class LandscapeTableViewCell: UITableViewCell {
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImage.contentMode =   UIView.ContentMode.scaleAspectFill
        self.thumbnailImage .clipsToBounds =  true
    }
}
