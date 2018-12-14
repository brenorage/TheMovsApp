//
//  FilterViewController.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 12/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

typealias FilterParams = [String : String]

protocol FilterViewDelegate: class {
    func didFinishFilter(with params: FilterParams)
}

class FilterViewController: UIViewController {
    
    enum State { case filterType, selectParams }
    
    let model: [FilterModel]
    
    private let filterView = FilterView()
    private let filterState: State
    private var filterParams: FilterParams = [:]
    
    private weak var filterDelegate: FilterViewDelegate?
    private var delegate: UITableViewDelegate?
    private var dataSource: UITableViewDataSource?
    
    override func loadView() {
        self.view = filterView
    }
    
    init(with model: [FilterModel], filterState: State, filterDelegate: FilterViewDelegate?) {
        self.model = model
        self.filterState = filterState
        self.filterDelegate = filterDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showDismissButton()
        setTableType()
    }
    
    private func setupView() {
        filterView.buttonCallback = { [weak self] in
            self?.buttonAction()
        }
    }
    
    private func showDismissButton() {
        let dismissButton = UIBarButtonItem(image: UIImage(named: "dismissIcon"), style: .plain, target: self, action: #selector(dismissNavController))
        navigationItem.rightBarButtonItem = dismissButton
    }
    
    private func buttonAction() {
        if !filterParams.isEmpty {
            filterDelegate?.didFinishFilter(with: filterParams)
            dismissFromButton()
        }
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
        title = "Filtro"
        filterView.setButtonTitle(with: "Aplicar")
        delegate = FilterTypeTableViewDelegate(modelList: model, view: self)
        dataSource = FilterTypeTableViewDataSource(modelList: model)
        filterView.register(cellType: FilterTypeCell.self)
        filterView.setupTableView(delegate, dataSource)
        filterView.reloadTableView()
    }
    
    private func setFilterOptionsState() {
        title = model.first?.filterType
        filterView.setButtonTitle(with: "Escolher")
        delegate = FilterOptionsTableViewDelegate(modelList: model, view: self)
        dataSource = FilterOptionsTableViewDataSource(modelList: model)
        filterView.register(cellType: FilterOptionCell.self)
        filterView.setupTableView(delegate, dataSource)
        filterView.reloadTableView()
    }
    
    private func dismissFromButton() {
        switch filterState {
        case .filterType:
            dismissNavController()
        case .selectParams:
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func dismissNavController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension FilterViewController: FilterTypeViewProtocol {
    func openVC(with vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fillFilterParams(with key: String, and value: String) {
        filterParams[key] = value
    }
    
    func removeFilterParam(with key: String) {
        filterParams.removeValue(forKey: key)
    }
}
