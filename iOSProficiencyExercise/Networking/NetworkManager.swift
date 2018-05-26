//
//  NetworkManager.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit

public protocol NetworkSession {
    func request(URLString: String, parameters: [String : Any]?, completion: @escaping ([String: Any]?, NSError?) -> ())
}

class NetworkManager:NetworkSession{
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = (JSONDictionary?, NSError?) -> ()
    var parser: JSONParser { return JSONParser() }
    
    func request(URLString: String, parameters: [String : Any]?, completion:@escaping QueryResult) {
        let url = URLRequest(url: URL(string:URLString)! )
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let _ = error {
                let APIError = NSError(domain: "error", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                OperationQueue.main.addOperation({
                    completion(nil, APIError)
                })
                return
            }
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    let APIError = NSError(domain: "error", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                    OperationQueue.main.addOperation({
                        completion(nil, APIError)
                    })
                    return
            }
            DispatchQueue.main.async {
                let response = self.parser.JSONObject(data: data)
                print(response)
                completion(response, nil)
            }
            
        }) .resume()
    }
}
