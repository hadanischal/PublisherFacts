//
//  FeedsDataSourceTests.swift
//  PublisherFactsTests
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

@testable import PublisherFacts
import XCTest

class FeedsDataSourceTests: XCTestCase {
    var dataSource: FeedsDataSource!

    override func setUp() {
        super.setUp()
        dataSource = FeedsDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testEmptyValueInDataSource() {
        dataSource.data.value = []
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in collection view")
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), 0, "Expected no cell in collection view")
    }

    func testValueInDataSource() {
        let responseResults: [ListModel] = MockData().getFeedslist()
        dataSource.data.value = responseResults
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), responseResults.count, "Expected responseResults.count cell in collection view")
    }

    func testValueCell() {
        dataSource.data.value = MockData().getFeedslist()
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: UIDevice.current.accessibilityFrame, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        let indexPath = IndexPath(row: 0, section: 0)
        guard let _ = dataSource.collectionView(collectionView, cellForItemAt: indexPath) as? CollectionViewCell else {
            XCTAssert(false, "Expected collectionViewCell class")
            return
        }
    }
}
