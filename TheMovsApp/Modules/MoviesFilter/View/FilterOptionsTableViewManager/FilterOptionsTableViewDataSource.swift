//
//  FilterOptionsTableViewDataSource.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 13/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterOptionsTableViewDataSource: NSObject {
    
    private let modelList: [FilterModel]
    
    init(modelList: [FilterModel]) {
        self.modelList = modelList
    }
}

extension FilterOptionsTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelList[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterOptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let option = modelList[indexPath.section].options[indexPath.row]
        cell.setOption(with: option)
        return cell
    }
}
