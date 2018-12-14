//
//  FilterOptionsTableViewDelegate.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 13/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterOptionsTableViewDelegate: NSObject {
    
    private let modelList: [FilterModel]
    private weak var view: FilterTypeViewProtocol?
    
    init(modelList: [FilterModel], view: FilterTypeViewProtocol) {
        self.modelList = modelList
        self.view = view
    }
}

extension FilterOptionsTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelList[indexPath.section]
        view?.fillFilterParams(with: model.filterType, and: model.options[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let model = modelList[indexPath.section]
        view?.removeFilterParam(with: model.filterType)
    }
}
