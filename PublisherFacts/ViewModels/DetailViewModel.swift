//
//  DetailViewModel.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {
    // output
    var title: Dynamic<String?>

    // input
    private let data: ListModel?
    private var dataSource: GenericDetailDataSource<ListModel>?

    init(withListModel dataList: ListModel, withDataSource dataSource: GenericDetailDataSource<ListModel>?) {
        self.data = dataList
        self.title = Dynamic(self.data?.title)
        self.dataSource = dataSource
        if let value = self.data {
            self.dataSource?.data.value = [value]
        }
    }
}
