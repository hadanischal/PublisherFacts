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
        XCTAssertEqual(dataSource.collectionView(collectionView, numberOfItemsInSection: 0), responseResults.count, "Expected responseResults.count cell in collection view")
    }
    
    func testValueCell() {
        dataSource.data.value = getDataValue()
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
        var responseResults = [ListModel]()
        guard let data = FileManager.readJson(forResource: "facts") else {
            XCTAssert(false, "Can't get data from facts.json")
            return responseResults
        }
        let completion : ((Result<FeedsModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                print(converter)
                responseResults = converter.rows
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
        return responseResults
    }
    
}
extension FileManager {
    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: FeedsDataSourceTests.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
            }
        }
        return nil
    }
}
