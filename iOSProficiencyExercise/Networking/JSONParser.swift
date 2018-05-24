//
//  JSONParser.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/24/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class JSONParser {
 
    func  JSONObject(data: Data) -> [String: Any]{
        var response: [String: Any]?
        if let value = String(data: data, encoding: String.Encoding.ascii) {
            if let jsonData = value.data(using: String.Encoding.utf8) {
                do {
                    response = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                    return response!
                } catch {
                    NSLog("ERROR \(error.localizedDescription)")
                    return response!
                }
            }else{
                return response!
            }
        }else{
            return response!
        }
        
    }
    
}
