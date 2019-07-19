//
//  ParserHelper.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    static func parse<T: Parceable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        do {
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                // init final result
                var finalResult : [T] = []
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        // check foreach dictionary if parseable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                            break
                        }
                    }
                }
                completion(.success(finalResult))
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    static func parse<T: Parceable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        if let value = String(data: data, encoding: String.Encoding.ascii) {
            if let jsonData = value.data(using: String.Encoding.utf8) {
                do {
                    if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject] {
                        print(dictionary)
                        // init final result
                        // check foreach dictionary if parseable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(let error):
                            completion(.failure(error))
                            break
                        case .success(let newModel):
                            completion(.success(newModel))
                            break
                        }
                    } else {
                        // not an array
                        completion(.failure(.parser(string: "Json data is not an array")))
                    }
                } catch {
                    // can't parse json
                    completion(.failure(.parser(string: "Error while parsing json data")))
                }
            }else{
                completion(.failure(.parser(string: "Error while parsing json data")))
            }
        }else{
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}

