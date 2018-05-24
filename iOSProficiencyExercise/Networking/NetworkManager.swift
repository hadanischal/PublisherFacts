//
//  NetworkManager.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation


class NetworkManager {
    
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = (JSONDictionary?, String) -> ()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var parser: JSONParser { return JSONParser() }
    
    func request(url: String, parameters: [String : Any]?, completion:@escaping QueryResult) {
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
                    // 6
                    DispatchQueue.main.async {
                        let response = self.parser.JSONObject(data: data)
                        print(response)
                        completion(response, self.errorMessage)
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
    }
    
    
}

