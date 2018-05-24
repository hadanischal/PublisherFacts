//
//  CollectionViewCell.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var bookLabel: UILabel!
    
    func displayContent(image: UIImage, title: String) {
        bookImage.image = image
        bookLabel.text = title
    }
    
}
