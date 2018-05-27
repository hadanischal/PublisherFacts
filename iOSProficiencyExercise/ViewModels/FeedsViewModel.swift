//
//  FeedsViewModel.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class FeedsViewModel {
    
    weak var dataSource : GenericDataSource<ListModel>?
    var cellDidSelect: GenericDataSource<Int>?
    var title: String?
    var selectedData: ListModel?
    weak var service: FeedsServiceProtocol?
    
    init(service: FeedsServiceProtocol, dataSource : GenericDataSource<ListModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
                
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchConverter { result in
            // print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    // reload data
                    self.dataSource?.data.value = converter.rows
                    self.title = converter.title
                    completion?(Result.success(true))
                    
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    
                    break
                }
            }
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath){
        let feedsValue = dataSource?.data.value[indexPath.row]
        selectedData = feedsValue
    }

}

