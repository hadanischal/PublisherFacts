//
//  ReusableView.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 25/9/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionViewCell: ReusableView {}
