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
    
    func testEmptyValueInDataSource() {
        dataSource.data.value = []  // giving empty data value
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        // collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
    }
    
    func testValueInDataSource() {
        let responseResults:[ListModel] = getDataValue()
        dataSource.data.value = responseResults
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 3, "Expected 3 cell in collection view")
    }
    
    func testValueCell() {
        let data = getDataValue()[0]
        dataSource.data.value = [data]
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: UIDevice.current.accessibilityFrame, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        let indexPath = IndexPath(row: 0, section: 0)
        guard let _ = dataSource.collectionView(collectionView, cellForItemAt: indexPath)as? CollectionViewCell else {
            XCTAssert(false, "Expected collectionViewCell class")
            return
        }
    }
    
    func getDataValue() ->[ListModel]{
        let rows = [
            [
                "description": "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
                "imageHref": "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg",
                "title": "Beavers",
                ],
            [
                "description": "Title",
                "imageHref": "http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png",
                "title": "Flag",
                ],
            [
                "description": "It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
                "imageHref": "http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg",
                "title": "Transportation",
                ]]
        var responseResults = [ListModel]()
        for properties in rows {
            let currentData = ListModel(dictionary: properties as [String : Any])
            responseResults.append(currentData)
        }
        return responseResults
    }
    
    
}
