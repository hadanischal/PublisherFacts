//
//  CollectionViewCell.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var rowImage: UIImageView?
    
    var feedsValue : ListModel? {
        didSet {
            guard let feeds = feedsValue else {
                return
            }
            print(feeds)
            titleLabel?.text = feeds.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bagroundView.backgroundColor = ThemeColor.contentViewBackgroundColor
        self.rowImage?.contentMode =   UIViewContentMode.scaleAspectFill
        self.rowImage? .clipsToBounds =  true
    }
    

}
