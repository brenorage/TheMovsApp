//
//  FilterViewController.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 12/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    enum State { case filterType, selectParams }
    typealias FilterParams = [String : String]
    
    private let filterView = FilterView()
    private let model: [FilterModel]
    private let filterState: State
    private var filterParams: FilterParams = [:]
    
    private var delegate: UITableViewDelegate?
    private var dataSource: UITableViewDataSource?
    
    var filterCallback: ((FilterParams) -> Void)?
    
    override func loadView() {
        self.view = filterView
    }
    
    init(with model: [FilterModel], filterState: State) {
        self.model = model
        self.filterState = filterState
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableType()
    }
    
    private func setTableType() {
        switch filterState {
        case .filterType:
            setFilterTypeState()
        case .selectParams:
            setFilterOptionsState()
        }
    }
    
    private func setFilterTypeState() {
        filterView.setButtonTitle(with: "Aplicar")
        delegate = FilterTypeTableViewDelegate(modelList: model, view: self)
        dataSource = FilterTypeTableViewDataSource(modelList: model)
        filterView.register(cellType: FilterTypeCell.self)
        filterView.setupTableView(delegate, dataSource)
        filterView.reloadTableView()
    }
    
    private func setFilterOptionsState() {
        filterView.setButtonTitle(with: "Escolher")
        delegate = FilterOptionsTableViewDelegate(modelList: model, view: self)
        dataSource = FilterOptionsTableViewDataSource(modelList: model)
        filterView.register(cellType: FilterOptionCell.self)
        filterView.setupTableView(delegate, dataSource)
        filterView.reloadTableView()
    }
}

extension FilterViewController: FilterTypeViewProtocol {
    func openVC(with vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func fillFilterParams(with key: String, and value: String) {
        filterParams[key] = value
    }
    
    func removeFilterParam(with key: String) {
        filterParams.removeValue(forKey: key)
    }
}
