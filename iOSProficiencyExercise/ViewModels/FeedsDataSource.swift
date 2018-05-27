//
//  FeedsDataSource.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class FeedsDataSource : GenericDataSource<ListModel>, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        let feedsValue = self.data.value[indexPath.row]
        cell.feedsValue = feedsValue
        ImageHelper().updateImageForCollectionViewCell(cell, inCollectionView: collectionView, imageURL: feedsValue.imageRef, atIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier:"toDetailViewController", sender: indexPath)
    }
    

}

