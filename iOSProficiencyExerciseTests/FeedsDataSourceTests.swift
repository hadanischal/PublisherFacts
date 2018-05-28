//
//  FeedsDataSourceTests.swift
//  iOSProficiencyExerciseTests
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import XCTest
@testable import iOSProficiencyExercise

class FeedsDataSourceTests: XCTestCase {
    var dataSource : FeedsDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = FeedsDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
//    func testEmptyValueInDataSource() {
//        
//        // giving empty data value
//        dataSource.data.value = []
//        
//        let collectionView = UICollectionView()
//        collectionView.dataSource = dataSource
//        
//        // expected one section
//        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
//        
//        // expected zero cells
//        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
//    }
//    
//    func testValueInDataSource() {
//        
//        // giving data value
//        let rows = [
//            [
//                "description": "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
//                "imageHref": "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg",
//                "title": "Beavers",
//                ],
//            [
//                "description": "<null>",
//                "imageHref": "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png",
//                "title": "Flag",
//                ],
//            [
//                "description": "It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
//                "imageHref": "http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg",
//                "title": "Transportation",
//                ]]
//        var responseResults = [ListModel]()
//        for properties in rows {
//            let currentData = ListModel(dictionary: properties)
//            responseResults.append(currentData)
//        }
//        dataSource.data.value = responseResults
//        
//        let collectionView = UICollectionView()
//        collectionView.dataSource = dataSource
//        
//        // expected one section
//        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in table view")
//        
//        // expected two cells
//        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 3, "Expected no cell in collection view")
//    }
//    
    func testValueCell() {
        // giving data value
        let dict =
            [
                "description": "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
                "imageHref": "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg",
                "title": "Beavers",
                ]
        
        let data = ListModel(dictionary: dict)
        dataSource.data.value = [data]
        
        let collectionView = UICollectionView()
        collectionView.dataSource = dataSource
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected collectionViewCell class
        guard let _ = dataSource.collectionView(collectionView, cellForItemAt: indexPath)as? CollectionViewCell else {
            XCTAssert(false, "Expected collectionViewCell class")
            return
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
