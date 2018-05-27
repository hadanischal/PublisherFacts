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
    var selectedData: ListModel?

    
    init(dataSource : GenericDataSource<ListModel>?) {
        self.dataSource = dataSource
    }
    
    func fetchCurrencies(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        let service:FeedsService = FeedsService()
        service.fetchConverter { result in
            // print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    // reload data
                    self.dataSource?.data.value = converter.rows
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

