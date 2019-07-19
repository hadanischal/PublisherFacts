//
//  FeedsViewModelTests.swift
//  PublisherFactsTests
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import PublisherFacts

class FeedsViewModelTests: XCTestCase {
    fileprivate class MockFeedsService: FeedsServiceProtocol {
        var feedsData: FeedsModel?
        func fetchFeeds(_ completion: @escaping ((Result<FeedsModel, ErrorResult>) -> Void)) {
            if let data = feedsData {
                completion(Result.success(data))
            } else {
                completion(Result.failure(ErrorResult.custom(string: "No converter")))
            }
        }
    }

    var viewModel: FeedsViewModel!
    var dataSource: GenericDataSource<ListModel>!
    fileprivate var service: MockFeedsService!

    override func setUp() {
        super.setUp()
        self.service = MockFeedsService()
        self.dataSource = GenericDataSource<ListModel>()
        self.viewModel = FeedsViewModel(service: service, dataSource: dataSource)
    }

    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchFeeds() {
        service.feedsData = FeedsModel(title: "Canada", rows: [])
        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default: break
            }
        }
    }

    func testFetchNoFeeds() {
        service.feedsData = nil
        viewModel.fetchServiceCall { result in
            switch result {
            case .success :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default: break
            }
        }
    }

}
