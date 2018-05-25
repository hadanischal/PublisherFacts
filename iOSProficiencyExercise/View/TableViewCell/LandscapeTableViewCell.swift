//
//  LandscapeTableViewCell.swift
//  iOSProficiencyExercise
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
        // Initialization code
        self.thumbnailImage.contentMode =   UIViewContentMode.scaleAspectFill
        self.thumbnailImage .clipsToBounds =  true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
