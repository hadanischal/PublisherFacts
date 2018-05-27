//
//  FeedsService.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol FeedsServiceProtocol : class {
    func fetchConverter(_ completion: @escaping ((Result<FeedsModel, ErrorResult>) -> Void))
}

final class FeedsService : RequestHandler, FeedsServiceProtocol {
    
    let endpoint = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var task : URLSessionTask?
    
    func fetchConverter(_ completion: @escaping ((Result<FeedsModel, ErrorResult>) -> Void)) {
        // cancel previous request if already in progress
        self.cancelFetchCurrencies()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}

