//
//  Optional.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol OptionalType {
    associatedtype Wrapped
    func intoOptional() -> Wrapped?
}

extension Optional : OptionalType {
    func intoOptional() -> Wrapped? {
        return self
    }
}
