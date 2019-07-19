//
//  Util.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Utility {
    func filterNil(_ value: AnyObject?) -> AnyObject?
}

struct Util {

}

extension Util: Utility {
    func filterNil(_ value: AnyObject?) -> AnyObject? {
        return ((value is NSNull || value == nil) ?  "" as AnyObject :  value)
    }
}
