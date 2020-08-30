//
//  CollectionViewCell.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var bagroundView: UIView!
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var rowImage: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        bagroundView.backgroundColor = ThemeColor.contentViewBackgroundColor
        rowImage?.contentMode = UIView.ContentMode.scaleAspectFill
        rowImage?.clipsToBounds = true
    }

    func configure(_ model: ListModel?) {
        guard let feeds = model else { return }
        titleLabel?.text = feeds.title
    }
}
