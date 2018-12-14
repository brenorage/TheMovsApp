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
    private var selectedIndex: IndexPath?
    private var selectedCell: FilterTypeCell?
    
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
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTypeCell else { return }
        selectedIndex = indexPath
        selectedCell = cell
        
        let model = modelList[indexPath.row]
        let filterViewController = FilterViewController(with: [model], filterState: .selectParams, filterDelegate: self)
        view?.openVC(with: filterViewController)
    }
}

extension FilterTypeTableViewDelegate: FilterViewDelegate {
    func didFinishFilter(with params: FilterParams) {
        guard
            let index = selectedIndex,
            let cell = selectedCell
        else { return }
        
        let selectedType = modelList[index.row].filterType
        
        guard let selectedOption = params[selectedType] else { return }
        cell.setSelectedOption(with: selectedOption)
        view?.fillFilterParams(with: selectedType, and: selectedOption)
    }
}
