//
//  FeedsViewModel.swift
//  PublisherFacts
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class FeedsViewModel: FeedsViewModelProtocol {
    //Input
    private var service: FeedsServiceProtocol?
    weak var dataSource: GenericDataSource<ListModel>?
    
    //Output
    var cellDidSelect: GenericDataSource<Int>?
    var title: String?
    var selectedData: ListModel?

    init(withService service: FeedsServiceProtocol, withDataSource dataSource: GenericDataSource<ListModel>?) {
        self.dataSource = dataSource
        self.service = service
    }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {

        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchFeeds { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    if
                        let rows = converter.rows,
                        let title = converter.title
                    {
                        self.dataSource?.data.value = rows
                        self.title = title
                        completion?(Result.success(true))
                    } else {
                        completion?(Result.failure(.custom(string: "Error while parsing json data")))
                    }

                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }

    func didSelectItemAt(indexPath: IndexPath) {
        let feedsValue = dataSource?.data.value[indexPath.row]
        selectedData = feedsValue
    }

}
