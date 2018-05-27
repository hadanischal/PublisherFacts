//
//  ListHelper.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/26/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

public protocol dataSession {
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath)
}

class ListHelper:dataSession{
    
    fileprivate let kLazyLoadCellImageViewTag = 1
    fileprivate let kLazyLoadPlaceholderImage = UIImage(named: "placeholder")!
    var imageManager: ImageManager { return ImageManager() }
        
    func updateImageForCollectionViewCell(_ cell: UICollectionViewCell, inCollectionView collectionView: UICollectionView, imageURL: String, atIndexPath indexPath: IndexPath) {
        let imageView = cell.viewWithTag(kLazyLoadCellImageViewTag) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        imageManager.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (collectionView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView.image = image
                }
            }
        }
    }
    
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath) {
        let imageView = cell.viewWithTag(kLazyLoadCellImageViewTag) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        imageManager.downloadImageFromURL(imageURL) { (success, image) -> Void in
            if success && image != nil {
                if (tableView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView.image = image
                }
            }
        }
    }
    
}
