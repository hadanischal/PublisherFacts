//
//  FeedsModel.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct FeedsModel: Decodable {
    let title: String?
    let rows: [ListModel]?
}

extension FeedsModel: Parceable {
    static func parseObject(data: Data) -> Result<FeedsModel, ErrorResult> {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(FeedsModel.self, from: data) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse FeedsModel results"))
        }
    }
}
