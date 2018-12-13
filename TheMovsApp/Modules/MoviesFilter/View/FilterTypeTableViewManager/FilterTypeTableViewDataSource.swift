//
//  FilterTypeTableViewDataSource.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 12/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterTypeTableViewDataSource: NSObject {
    
    private let modelList: [FilterModel]
    
    init(modelList: [FilterModel]) {
        self.modelList = modelList
    }
}

extension FilterTypeTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FilterTypeCell.self, for: indexPath)
        cell.setFilterTypeLabel(with: modelList[indexPath.row].filterType)
        return cell
    }
}
