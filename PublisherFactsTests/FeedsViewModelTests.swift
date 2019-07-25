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

    var viewModel: FeedsViewModel!
    private var mockDataSource: GenericDataSource<ListModel>!
    private var mockService: MockFeedsService!

    override func setUp() {
        super.setUp()
        self.mockService = MockFeedsService()
        self.mockDataSource = GenericDataSource<ListModel>()
        self.viewModel = FeedsViewModel(withService: mockService, withDataSource: mockDataSource)
    }

    override func tearDown() {
        self.viewModel = nil
        self.mockDataSource = nil
        self.mockService = nil
        super.tearDown()
    }

    func testFetchFeeds() {
        mockService.feedsData = FeedsModel(title: "Canada", rows: [])
        viewModel.fetchServiceCall { result in
            switch result {
            case .failure :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default: break
            }
        }
    }

    func testFetchNoFeeds() {
        mockService.feedsData = nil
        viewModel.fetchServiceCall { result in
            switch result {
            case .success :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default: break
            }
        }
    }

}
