//
//  ViewControllerTests.swift
//  iOSProficiencyExerciseTests
//
//  Created by Nischal Hada on 5/26/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import iOSProficiencyExercise

class ViewControllerTests: XCTestCase {
    var controllerUnderTest: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controllerUnderTest = storyboard.instantiateInitialViewController() as! ViewController
        let _ = controllerUnderTest.view ////load view hierarchy
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testSUT_CanInstantiateViewController() {
        XCTAssertNotNil(controllerUnderTest)
    }
    
    func testSUT_CollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(controllerUnderTest.collectionView)
    }
    
    func testSUT_HasItemsForCollectionView() {
        XCTAssertNotNil(controllerUnderTest.responseResults)
    }
    
    func testSUT_ShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(controllerUnderTest.collectionView.dataSource)
    }
    
    func testSUT_ConformsToCollectionViewDataSource() {
        XCTAssert(controllerUnderTest.conforms(to: UICollectionViewDataSource.self))
    }
    
    func testSUT_ShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(controllerUnderTest.collectionView.delegate)
    }
    
    func testSUT_ConformsToCollectionViewDelegate() {
        XCTAssert(controllerUnderTest.conforms(to: UICollectionViewDelegate.self))
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        XCTAssert(controllerUnderTest.conforms(to: UICollectionViewDelegateFlowLayout.self))
    }
    
    // MARK: - Storyboard Segues
    
    // utility for finding segues
    func hasSegueWithIdentifier(id: String) -> Bool {
        let segues = controllerUnderTest.value(forKey: "toDetailViewController") as? [NSObject]
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        return (filtered!.count >= 0)
    }
    
    func testSUT_HasSegue_ForTransitioningTo_ViewConrollerOne() {
        let targetIdentifier = controllerUnderTest.segueIdentifier
        XCTAssertTrue(hasSegueWithIdentifier(id: targetIdentifier))
    }
    
}



