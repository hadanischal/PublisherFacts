//
//  DetailViewModel.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class DetailViewModel: DetailViewModelProtocol {
    //outut
    var title: Dynamic<String?>
    var description: Dynamic<String?>
    var imageHref: Dynamic<String?>
    //input
    private let data: ListModel?
    
    init(withListModel dataList: ListModel) {
        self.data = dataList
        self.title = Dynamic(self.data?.title)
        self.description = Dynamic(self.data?.description)
        self.imageHref = Dynamic(self.data?.imageHref)
    }
}
