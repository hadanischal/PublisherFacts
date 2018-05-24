//
//  Networking.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class Networking{
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Model]?, String) -> ()
    
    // 1
    let defaultSession = URLSession(configuration: .default)
    // 2
    var dataTask: URLSessionDataTask?
    var model: [Model] = []
    var errorMessage = ""
    
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        // 1
        dataTask?.cancel()
        // 2
        if var urlComponents = URLComponents(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") {
            // 3
            guard let url = urlComponents.url else { return }
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                // 5
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    print(data)
                    self.updateResults(data)
                    // 6
                    DispatchQueue.main.async {
                        
                        print(self.model)
                        completion(self.model, self.errorMessage)
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
    }
    
    fileprivate func updateResults(_ data: Data) {
        var response: JSONDictionary?
      //  model.removeAll()
        
        if let value = String(data: data, encoding: String.Encoding.ascii) {
            
            if let jsonData = value.data(using: String.Encoding.utf8) {
                do {
                    response = try JSONSerialization.jsonObject(with: jsonData, options: []) as? JSONDictionary
                    
                    guard let array = response!["rows"] as? [Any] else {
                        errorMessage += "Dictionary does not contain results"
                        return
                    }
                    self.setupResponseList(array as [AnyObject])

                } catch {
                    NSLog("ERROR \(error.localizedDescription)")
                }
            }
        }
        
        print(response ?? "")
        
        
        
    }
    
    
    func setupResponseList (_ list :[AnyObject] ) {
        for properties in list {
            let dictionary = properties as? JSONDictionary
            guard let title = dictionary!["title"] as? String else { return }
            guard let description = dictionary!["description"] as? String else { return }
            guard let imageURLString = dictionary!["imageHref"] as? String else { return }
            let imageURL = URL(string: imageURLString)
            
            let currentData = Model(title: title, description: description, imageRef: imageURL)
            self.model.append(currentData)
        }
        
    }
    
}

