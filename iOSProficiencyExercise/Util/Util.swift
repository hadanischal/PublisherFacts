//
//  Util.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Utility{
    func filterNil(_ value : AnyObject?) -> AnyObject?
}

class Util {
    
}

extension Util: Utility {
    func filterNil(_ value : AnyObject?) -> AnyObject? {
        //print(value)
        if value is NSNull || value == nil {
            return "" as AnyObject
        } else {
            return value
        }
    }
}

//    object.feature = nullToNil(dict["feature"])




