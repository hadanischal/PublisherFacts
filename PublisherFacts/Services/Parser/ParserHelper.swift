//
//  ParserHelper.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(data: Data) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    static func parse<T: Parceable>(data: Data, completion: (Result<[T], ErrorResult>) -> Void) {
        switch T.parseObject(data: data) {
        case let .failure(error):
            completion(.failure(error))
        case let .success(newModel):
            completion(.success([newModel]))
        }
    }

    static func parse<T: Parceable>(data: Data, completion: (Result<T, ErrorResult>) -> Void) {
        if
            let response = String(data: data, encoding: String.Encoding.ascii),
            let data = response.data(using: String.Encoding.utf8) {
            switch T.parseObject(data: data) {
            case let .failure(error):
                completion(.failure(error))
            case let .success(newModel):
                completion(.success(newModel))
            }
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
