//
//  FeedsService.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class FeedsService: RequestHandler, FeedsServiceProtocol {
    let endpoint = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var task: URLSessionTask?

    func fetchFeeds(_ completion: @escaping ((Result<FeedsModel, ErrorResult>) -> Void)) {
        self.cancelFetchFeeds()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetchFeeds() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
