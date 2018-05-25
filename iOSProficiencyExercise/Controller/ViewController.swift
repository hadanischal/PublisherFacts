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
        if !data.imageRef.isEmpty{
            cell.rowImage.downloadedFrom(data.imageRef)
        }else{
            cell.rowImage.image = UIImage(named:"placeholderImage")
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

extension ViewController{
    
    func serviceCall() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        networkManager.request(url: url, parameters: nil){ results, errorMessage in
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

                self.collectionView.reloadData()
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
    }
    
    func setupResponseList (_ list :[Any] ) {
        
        for properties in list {
            let dictionary = properties as? JSONDictionary
            let title = util.filterNil(dictionary!["title"] as AnyObject) as! String
            let description = util.filterNil(dictionary!["description"] as AnyObject) as! String
            let imageRef = util.filterNil(dictionary!["imageHref"] as AnyObject) as! String
 
            let currentData = ListModel(title: title, description: description, imageRef: imageRef)
            self.responseResults.append(currentData)
        }
        
    }
    
    func setupNavigationTitle (_ title :Any ) {
        let title = util.filterNil(title as AnyObject) as! String
        self.title = title
    }
    
}

