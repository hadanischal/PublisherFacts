//
//  DetailViewDataSource.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 7/28/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

class GenericDetailDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    fileprivate let portraitReuseIdentifier = "PortraitTableViewCell"
    fileprivate let landscapeReuseIdentifier = "LandscapeTableViewCell"
    fileprivate let imageHelper = ImageHelper()
}

class DetailViewDataSource: GenericDetailDataSource<ListModel>, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1: PortraitTableViewCell?
        if UIDevice.current.orientation.isPortrait {
            cell1 = tableView.dequeueReusableCell(withIdentifier: portraitReuseIdentifier, for: indexPath) as? PortraitTableViewCell
        } else {
            cell1 = tableView.dequeueReusableCell(withIdentifier: landscapeReuseIdentifier, for: indexPath) as? PortraitTableViewCell
        }

        guard let cell = cell1 else {
            assertionFailure("PortraitTableViewCell not found")
            return UITableViewCell()
        }

        let feedsValue = self.data.value[indexPath.row]
        cell.configure(feedsValue)
        guard let imageUrl = feedsValue.imageHref else { return cell }
        self.imageHelper.updateImageForTableViewCell(cell, inTableView: tableView, imageURL: imageUrl, atIndexPath: indexPath)
        return cell
    }
}
