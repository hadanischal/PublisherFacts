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
    func apiCall(completion: @escaping () -> Void)
    func updateImageForCollectionViewCell(_ cell: UICollectionViewCell, inCollectionView collectionView: UICollectionView, imageURL: String, atIndexPath indexPath: IndexPath)
    func updateImageForTableViewCell(_ cell: UITableViewCell, inTableView tableView: UITableView, imageURL: String, atIndexPath indexPath: IndexPath)
}

class ListHelper:dataSession{
    
    fileprivate let kLazyLoadCellImageViewTag = 1
    fileprivate let kLazyLoadPlaceholderImage = UIImage(named: "placeholder")!
    typealias JSONDictionary = [String: Any]
    var networkManager: NetworkManager { return NetworkManager() }
    var parser: JSONParser { return JSONParser() }
    var util: Util { return Util() }
    var imageManager: ImageManager { return ImageManager() }
    
    var responseResults = [ListModel]()
    var title: String = ""
    
    func apiCall(completion: @escaping () -> Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        networkManager.request(URLString: url, parameters: nil){ results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let response = results {
                print(results ?? "")
                guard let title = response["title"]else {
                    return
                }
                
                self.title = self.util.filterNil(title as AnyObject) as! String
                if let array = response["rows"] as? [AnyObject] {
                    for properties in array {
                        let currentData = ListModel(dictionary: properties as! [String : Any])
                        self.responseResults.append(currentData)
                    }
                    completion()
                }
                
            }
        }
    }
    
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
