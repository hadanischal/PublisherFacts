//
//  FeedsServiceTests.swift
//  iOSProficiencyExerciseTests
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import iOSProficiencyExercise

class FeedsServiceTests: XCTestCase {

    func testCancelRequest() {
        let service : FeedsService! = FeedsService()

        // giving a "previous" session
        service.fetchConverter{ (_) in
            // ignore call
        }
        
        // Expected to task nil after cancel
        service.cancelFetchCurrencies()
        XCTAssertNil(service.task, "Expected task nil")
    }

    
}
