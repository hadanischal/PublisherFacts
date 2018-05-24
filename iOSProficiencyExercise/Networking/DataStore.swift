//
//  DataStore.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var audiobooks: [Audiobook] = []
    var images: [UIImage] = []
    
    func getBooks(completion: @escaping () -> Void) {
        
//        Networking.getAudiobooksAPI { (json) in
//            
//            // debugPrint(json)
//            // let feed = json?["feed"] as? AudiobookJSON
//            if let results = json?["rows"] as? [AudiobookJSON] {
//                for property in results {
//                    let newAudiobook = Audiobook(dictionary: property)
//                    self.audiobooks.append(newAudiobook)
//                }
//                completion()
//            }
//        }
    }
    
    
    
    func getBookImages(completion: @escaping () -> Void) {
        getBooks {
            for book in self.audiobooks {
 
                guard let myString = book.coverImage, !myString.isEmpty else {
                    print("String is nil or empty.")
                    return // or break, continue, throw
                }
                let url = URL(string: myString)
                print("Download Started")
                self.getDataFromUrl(url: url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? url?.lastPathComponent ?? "")
                    print("Download Finished")
                    DispatchQueue.main.async() {
                        let image = UIImage(data: data)
                        self.images.append(image!)
                    }
                }
                /*
                 let data = try? Data(contentsOf: url!)
                 if let imageData = data {
                 let image = UIImage(data: imageData)
                 self.images.append(image!)
                 }*/
            }
            OperationQueue.main.addOperation {
                completion()
            }
        }
    }
    
    
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                // self.imageView.image = UIImage(data: data)
                let image = UIImage(data: data)
                self.images.append(image!)
            }
        }
    }
}
