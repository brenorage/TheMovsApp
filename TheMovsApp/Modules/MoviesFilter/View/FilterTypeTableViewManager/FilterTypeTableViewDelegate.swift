//
//  FilterTypeTableViewDelegate.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 12/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterTypeTableViewDelegate: NSObject {
    
    private let modelList: [FilterModel]
    private weak var view: FilterTypeViewProtocol?
    
    init(modelList: [FilterModel], view: FilterTypeViewProtocol) {
        self.modelList = modelList
        self.view = view
    }
}

extension FilterTypeTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelList[indexPath.row]
        let filterViewController = FilterViewController(with: [model], filterState: .selectParams)
        filterViewController.filterCallback = { [weak self] param in
            guard
                let cell = tableView.cellForRow(at: indexPath) as? FilterTypeCell,
                let selectedOption = param[model.filterType]
            else { return }
            cell.setSelectedOption(with: selectedOption)
            self?.view?.fillFilterParams(with: model.filterType, and: selectedOption)
        }
        view?.openVC(with: filterViewController)
    }
}
