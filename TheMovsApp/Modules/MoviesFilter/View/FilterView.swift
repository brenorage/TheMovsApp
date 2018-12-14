//
//  FilterView.swift
//  TheMovsApp
//
//  Created by Breno Rage Aboud on 12/12/2018.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    private let filterTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton.init(frame: .zero)
        button.backgroundColor = .lightYellow
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    var buttonCallback: (() -> Void)?
    
    @objc private func buttonAction() {
        buttonCallback?()
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        filterTableView.register(cellType)
    }
    
    func setupTableView(_ delegate: UITableViewDelegate?, _ dataSource: UITableViewDataSource?) {
        filterTableView.delegate = delegate
        filterTableView.dataSource = dataSource
    }
    
    func reloadTableView() {
        filterTableView.reloadData()
    }
    
    func setButtonTitle(with title: String) {
        applyButton.setTitle(title, for: .normal)
    }
}

extension FilterView: CodeView {
    func buildViewHierarchy() {
        addSubview(filterTableView)
        addSubview(applyButton)
    }
    
    func setupConstraints() {
        filterTableView.snp.makeConstraints { maker in
            maker.top.left.right.equalTo(safeAreaLayoutGuide).inset(5)
            maker.bottom.equalTo(applyButton.snp.top).offset(10)
        }
        
        applyButton.snp.makeConstraints { maker in
            maker.bottom.left.right.equalTo(safeAreaLayoutGuide).inset(10)
            maker.height.equalTo(50)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
