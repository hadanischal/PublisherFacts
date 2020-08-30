//
//  Dynamic.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}
