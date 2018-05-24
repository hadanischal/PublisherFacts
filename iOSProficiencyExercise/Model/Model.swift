//
//  Model.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

 struct Model {
    
    let title: String?
    let description: String?
    let imageRef: URL?
 
    init(title: String?,description: String?,imageRef: URL?) {
        self.title = title
        self.description = description
        self.imageRef = imageRef
    }
    
}
