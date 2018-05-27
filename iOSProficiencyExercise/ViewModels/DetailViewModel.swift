//
//  DetailViewModel.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct DetailViewModel {
    weak var dataSource : GenericDetailDataSource<ListModel>?
    weak var service: FeedsServiceProtocol?
    
    init(service: FeedsService, dataSource : GenericDetailDataSource<ListModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchCurrencies(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        
        service.fetchConverter { result in
            
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
}

