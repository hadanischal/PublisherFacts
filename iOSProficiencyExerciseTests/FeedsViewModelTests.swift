//
//  FeedsViewModelTests.swift
//  iOSProficiencyExerciseTests
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import iOSProficiencyExercise

class FeedsViewModelTests: XCTestCase {
    
    var viewModel : FeedsViewModel!
    var dataSource : GenericDataSource<ListModel>!
    fileprivate var service : MockFeedsService!

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
        
        // giving a service mocking currencies
        service.feedsData = FeedsModel(title: "Canada", rows: [])
 
        // expected completion to succeed
        viewModel.fetchServiceCall{ result in
            switch result {
            case .failure(_) :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default:
                break
            }
        }
    }
    
    func testFetchNoFeeds() {
        
        // giving a service mocking error during fetching currencies
        service.feedsData = nil
        
        // expected completion to fail
        viewModel.fetchServiceCall { result in
            switch result {
            case .success(_) :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default:
                break
            }
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

fileprivate class MockFeedsService : FeedsServiceProtocol {
    
    var feedsData : FeedsModel?
    
    func fetchConverter(_ completion: @escaping ((Result<FeedsModel, ErrorResult>) -> Void)) {
        
        if let data = feedsData {
            completion(Result.success(data))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}
