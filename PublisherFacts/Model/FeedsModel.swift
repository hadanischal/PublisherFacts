//
//  FeedsModel.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct FeedsModel {
    let title: String
    let rows: [ListModel]
}

extension FeedsModel : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<FeedsModel, ErrorResult> {
        if let base = dictionary["title"] as? String,
            let rows = dictionary["rows"] as? [AnyObject] {
            var responseResults = [ListModel]()
            for properties in rows {
                let currentData = ListModel(dictionary: properties as! [String:Any])
                responseResults.append(currentData)
            }
            let conversion = FeedsModel(title: base, rows: responseResults)
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}

