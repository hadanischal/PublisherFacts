//
//  RequestHandler.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class RequestHandler {
    let reachability = Reachability()!
    func networkResult<T: Parceable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            return { dataResult in
                DispatchQueue.global(qos: .background).async(execute: {
                    switch dataResult {
                    case let .success(data):
                        ParserHelper.parse(data: data, completion: completion)
                    case let .failure(error):
                        print("Network error \(error)")
                        completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    }
                })
            }
    }

    func networkResult<T: Parceable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            return { dataResult in
                print(dataResult)
                DispatchQueue.global(qos: .background).async(execute: {
                    switch dataResult {
                    case let .success(data):
                        ParserHelper.parse(data: data, completion: completion)
                    case let .failure(error):
                        print("Network error \(error)")
                        completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    }
                })
            }
    }
}
