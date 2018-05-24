//
//  Dictionary.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

extension Dictionary where Value: OptionalType {
    func filterNil() -> [Key: Value.Wrapped] {
        var result: [Key: Value.Wrapped] = [:]
        for (key, value) in self {
            if let unwrappedValue = value.intoOptional() {
                result[key] = unwrappedValue
            }
        }
        return result
    }
}




/*
 typealias AudiobookJSON = [String: Any]
 
 struct Networking1 {
 
 static func getAudiobooksAPI(completion: @escaping (AudiobookJSON?) -> Void){
 
 let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
 URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
 
 if let d = data {
 if let value = String(data: d, encoding: String.Encoding.ascii) {
 
 if let jsonData = value.data(using: String.Encoding.utf8) {
 do {
 let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
 completion(json)
 
 /*
 if let arr = json["rows"] as? [[String: Any]] {
 debugPrint(arr)
 }*/
 
 } catch {
 NSLog("ERROR \(error.localizedDescription)")
 }
 }
 }
 
 }
 }.resume()
 }
 
 
 
 }
 */

/*{
 let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
 
 let session = URLSession.shared
 
 guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
 
 let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
 
 guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
 
 do {
 let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? AudiobookJSON
 completion(responseJSON)
 } catch {
 print("Could not get API data. \(error), \(error.localizedDescription)")
 }
 }
 dataTask.resume()
 }
 }
 */
