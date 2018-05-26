//
//  ViewController.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    fileprivate let reuseIdentifier = "collectionViewCell"
    fileprivate let segueIdentifier = "toDetailViewController"
    fileprivate let kLazyLoadPlaceholderImage = UIImage(named: "placeholder")!
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let kLazyLoadCellImageViewTag = 1
    fileprivate let util = Util()
    fileprivate let networkManager = NetworkManager()
    fileprivate let imageManager = ImageManager()
    typealias JSONDictionary = [String: Any]
    fileprivate var responseResults = [ListModel]()
    var images: [UIImage] = []
    @IBOutlet var collectionView: UICollectionView!
}

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.serviceCall()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let indexPath = (sender as! IndexPath);
            let data :ListModel = self.responseResults[indexPath.row] as ListModel
            if let controller = segue.destination as? DetailViewController {
                controller.data = data
            }
        }
    }
    
}


// MARK:
// MARK: Setup UI

extension ViewController {
    func setupUI() {
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = ThemeColor.collectionViewBackgroundColor
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responseResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let data = self.responseResults[indexPath.row]
        cell.displayContent(title: data.title)
        updateImageForCell(cell, inCollectionView: collectionView, imageURL: data.imageRef, atIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueIdentifier, sender: indexPath)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 21
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
}

extension ViewController{
    
    func updateImageForCell(_ cell: UICollectionViewCell, inCollectionView collectionView: UICollectionView, imageURL: String, atIndexPath indexPath: IndexPath) {
        let imageView = cell.viewWithTag(kLazyLoadCellImageViewTag) as! UIImageView
        imageView.image = kLazyLoadPlaceholderImage
        let data = self.responseResults[indexPath.row]
        // load image.
        let imageURL = data.imageRef
        imageManager.downloadImageFromURL(imageURL!) { (success, image) -> Void in
            if success && image != nil {
                if (collectionView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    imageView.image = image
                }
            }
        }
    }
    
    // MARK: - Lazy Loading of cells
    func loadImagesForOnscreenRows() {
        self.collectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
}


extension ViewController{
    func serviceCall() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        networkManager.request(URLString: url, parameters: nil){ results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let response = results {
                print(results ?? "")
                guard let title = response["title"]else {
                    return
                }
                guard let array = response["rows"] as? [Any] else {
                    return
                }
                self.setupNavigationTitle(title)
                self.setupResponseList(array as [Any])
            }
        }
    }
    
    func setupResponseList (_ list :[Any]) {
        for properties in list {
            let dictionary = properties as? JSONDictionary
            let title = util.filterNil(dictionary!["title"] as AnyObject) as! String
            let description = util.filterNil(dictionary!["description"] as AnyObject) as! String
            let imageRef = util.filterNil(dictionary!["imageHref"] as AnyObject) as! String
            let currentData = ListModel(title: title, description: description, imageRef: imageRef)
            self.responseResults.append(currentData)
        }
        self.collectionView.reloadData()
    }
    
    func setupNavigationTitle (_ title :Any ) {
        let title = util.filterNil(title as AnyObject) as! String
        self.title = title
    }
}
