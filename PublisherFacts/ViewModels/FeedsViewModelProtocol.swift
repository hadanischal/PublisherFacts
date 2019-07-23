//
//  FeedsViewModelProtocol.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 7/21/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol FeedsViewModelProtocol {
    var title: String? { get set }
    var cellDidSelect: GenericDataSource<Int>? { get set }
    var selectedData: ListModel? { get set }
    
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)?)
    func didSelectItemAt(indexPath: IndexPath)
}
