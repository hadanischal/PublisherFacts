//
//  String.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

extension String {
    func filterNil(_ value: AnyObject?) -> AnyObject? {
        if value is NSNull || value == nil {
            return "" as AnyObject
        } else {
            return value
        }
    }

    var isNullOrEmpty: Bool {
        return self.isEmpty
    }
}
