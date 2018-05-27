//
//  DetailDataSource.swift
//  iOSProficiencyExercise
//
//  Created by Nischal Hada on 5/27/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import UIKit


class GenericDetailDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}


class DetailDataSource : GenericDetailDataSource<ListModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortraitTableViewCell", for: indexPath) as! PortraitTableViewCell

//        let currencyRate = self.data.value[indexPath.row]
//        cell.currencyRate = currencyRate
        
        return cell
    }
}


