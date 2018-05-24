//
//  ViewController.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var responseResults:[ListModel] = [ListModel]()
    
    let networkManager = NetworkManager()
    typealias JSONDictionary = [String: Any]
    
    
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
    
    
    func serviceCall() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        networkManager.request(url: url, parameters: nil){ results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let response = results {
                print(results ?? "")
                guard let array = response["rows"] as? [Any] else {
                    // let errorMessage = "Dictionary does not contain rows"
                    return
                }
                self.setupResponseList(array as [Any])
                self.collectionView.reloadData()
            }
            if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
        }
    }
    
    func setupResponseList (_ list :[Any] ) {
        
        print("list:",list)

        
        for properties in list {
            let dictionary = properties as? JSONDictionary
              let title = (dictionary!["title"] as? String)
              let description = dictionary!["description"] as? String
              let imageURLString = dictionary!["imageHref"] as? String
            let imageURL = URL(string: "")
            
            let currentData = ListModel(title: title, description: description, imageRef: imageURL)
            self.responseResults.append(currentData)
        }
        
    }
    
}



extension ViewController:UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.responseResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        //        let book = store.audiobooks[indexPath.row]
        //
        //        cell.displayContent(image: store.images[indexPath.row], title: book.name!)
        
        return cell
        
    }
}
