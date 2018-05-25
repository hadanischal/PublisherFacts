//
//  ViewController.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "collectionViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    fileprivate var responseResults = [ListModel]()
    var images: [UIImage] = []
    
    fileprivate let util = Util()
    fileprivate let networkManager = NetworkManager()
    typealias JSONDictionary = [String: Any]
    @IBOutlet var collectionView: UICollectionView!
    
}


// MARK: - Private

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceCall()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
        cell.displayContent(title: data.title,description: data.description,imageRef: data.imageRef)
        cell.rowImage.imageFromServerURL(urlString: data.imageRef)
        if images.count != 0{
            cell.rowImage.image = images[indexPath.row]
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}




// MARK: UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func CollectionViewSetUp() -> Void{
        
        self.collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //0.0
        self.collectionView.backgroundColor = ThemeColor.collectionViewBackgroundColor
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
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


//MARK: - CustomLayout Delegate
//extension ViewController : CustomLayoutDelegate {
//
//    // 1. Returns the photo height
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
//        return photos[indexPath.item].image.size.height
//    }
//
//}


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
                self.setupResponseList(array as [Any],completion: {
                    self.getImages(completion: {
                        self.collectionView.reloadData()
                    })
                    
                })
                
            }
        }
    }
    
    func setupResponseList (_ list :[Any], completion: @escaping () -> Void) {
        
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
    
    
    func getImages(completion: @escaping () -> Void) {
        
        for properties in self.responseResults {
            guard let URLString = properties.imageRef,
                let imageData = try? Data(contentsOf: URL(string:URLString)! as URL) else {
                    break
            }
            if let image = UIImage(data: imageData) {
                self.images.append(image)
                
            }else{
                let image = UIImage(named:"placeholderImage")
                self.images.append(image!)
            }
            
            //            let url = URL(string: properties.imageRef)
            //            let data = try? Data(contentsOf: url!)
            //            if let imageData = data {
            //                let image = UIImage(data: imageData)
            //                self.images.append(image!)
            //            }
        }
        completion()
        
    }
    
    
}

/*
 {
 super.viewDidLoad()
 
 if let patternImage = UIImage(named: "Pattern") {
 view.backgroundColor = UIColor(patternImage: patternImage)
 }
 collectionView?.backgroundColor = UIColor.clear
 collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
 // Set the PinterestLayout delegate
 if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
 layout.delegate = self
 }
 }
 */

/*
 guard let URLString = dictionary!["imageHref"],
 let imageData = try? Data(contentsOf: URL(string:URLString as! String)! as URL) else {
 break
 }
 if let image = UIImage(data: imageData) {
 currentData.thumbnail = image
 }
 
 */
