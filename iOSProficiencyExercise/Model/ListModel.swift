//
//  ListModel.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct ListModel {
    
    let title: String!
    let description: String!
    let imageRef: String!
    
    init(title: String!,description: String!,imageRef: String!) {
        self.title = title
        self.description = description
        self.imageRef = imageRef
    }
    
}
