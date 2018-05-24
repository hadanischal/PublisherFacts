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
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var rowImage: UIImageView!
    
    func displayContent(title: String,description: String,imageRef: URL) {
        titleLabel.text = title
        descriptionLabel.text = description
        
        // rowImage.image = image
        
    }
    
}
